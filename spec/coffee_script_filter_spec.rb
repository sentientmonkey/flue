require "./spec/test_helper.rb"

describe CoffeeScriptFilter do
  it "should filter coffeescript" do
    CoffeeScriptFilter.new.call("number = 42").must_equal (<<-eos
(function() {
  var number;

  number = 42;

}).call(this);
eos
)
  end

  it "should filter coffeescript with variables" do
    CoffeeScriptFilter.new.call("alert number", :variables => {:number => 42}).must_equal (<<-eos
(function() {
  var number;

  number = 42;

  alert(number);

}).call(this);
eos
)
  end

end
