# -*- coding:utf-8 -*
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faker::Japanese::Name do
  before do
    require 'activesupport'
    @expect = {
      :first_name => [['良子', 'リョウコ'], ['武', 'タケシ'], ['修三', 'シュウゾウ']],
      :last_name => [['木村', 'キムラ'], ['田中', 'タナカ'], ['佐藤', 'サトウ']]
    }
    @expect.each do |k, v|
      Faker::Japanese::Name.instance_variable_set("@#{k}s", v)
    end
  end

  it "#first_name, #last_name" do
    @expect.each do |k, v|
      names = v.map {|n| n[0] }
      yomis = v.map {|n| n[1] }
      name = Faker::Japanese::Name.send(k)
      names.should include name
      yomis.should include name.yomi
    end
  end
end
