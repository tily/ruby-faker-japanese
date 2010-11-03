#!/usr/bin/env ruby
require 'erb'

DEFAULT_DIC_PATH = '/var/lib/chasen/dic/naist-jdic-utf8/naist-jdic.dic'
NAME_CLASS_PATH  = File.dirname(__FILE__) + '/../lib/faker/japanese/name.rb'

def parse_dic(dic_path)
  names = Hash.new {|h,k| h[k] = [] }
  File.open(dic_path).each do |line|
    if type = line[/\(品詞 \(名詞 固有名詞 人名 (姓|名)\)\)/, 1]
      key = type == '姓' ? :last : :first
      name = line[/\(\(見出し語 \((.+) \d+\)\)/, 1]
      yomi = line[/\(読み (.+?)\)/, 1]
      if match = yomi[/^\{(.+)\}$/, 1]
        yomis = match.split('/')
        yomis.each do |yomi|
          names[key] << [name, yomi]
        end
      else
        names[key] << [name, yomi]
      end
    end
  end
  names
end

def write_class(names)
  erb = ERB.new(DATA.read, nil, '-')
  file = File.open(NAME_CLASS_PATH, 'w')
  file.write(erb.result(binding))
end

def main
  dic_path = ARGV[0] || DEFAULT_DIC_PATH
  names = parse_dic(dic_path)
  write_class(names)
end

main

__END__

module Faker
  module Japanese
    module Name
      extend self

      <%- [:first, :last].each do |key| -%>
      @<%= key %>_names = [
        <%- names[key].each do |name, yomi| -%>
        ['<%= name %>', '<%= yomi %>'],
        <%- end -%>
      ]
      <%- end -%>

      def name
        first, last = first_name, last_name
        name = [last, first].join(' ')
        set_yomi(name, last.yomi + ' ' + first.yomi)
        name
      end

      [:first_name, :last_name].each do |m|
        define_method m do
          chosen = instance_variable_get("@#{m}s").rand
          name = chosen[0]
          set_yomi(name, chosen[1])
          name
        end
      end

      def set_yomi(name, yomi)
        name.instance_variable_set('@yomi', yomi)
        def name.yomi; @yomi end
      end
    end
  end
end
