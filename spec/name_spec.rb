require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Faker::Japanese::Name do
  before do
    @expect = {
      :first_name => [['良子', 'リョウコ'], ['武', 'タケシ'], ['修三', 'シュウゾウ']],
      :last_name => [['木村', 'キムラ'], ['田中', 'タナカ'], ['佐藤', 'サトウ']]
    }
    @expect.each do |k, v|
      Faker::Japanese::Name.instance_variable_set("@#{k}s", v)
    end
  end

  it "#name" do
    expect = {
      :first_name => ['太郎', 'タロウ'],
      :last_name => ['安藤', 'アンドウ']
    }
    expect.each do |k, v|
      name = v[0]
      name.stub!(:yomi => v[1])
      Faker::Japanese::Name.should_receive(k).and_return(name)
    end
    name = Faker::Japanese::Name.name
    name.should == "#{expect[:last_name][0]} #{expect[:first_name][0]}"
    name.yomi.should == "#{expect[:last_name][1]} #{expect[:first_name][1]}"
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

  it "#set_yomi" do
    expect = 'ヨミ'
    o = Object.new
    Faker::Japanese::Name.set_yomi(o, expect) 
    o.yomi.should == expect
  end
end
