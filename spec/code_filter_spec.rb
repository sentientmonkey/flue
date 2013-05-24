require "./spec/test_helper.rb"

describe CodeFilter do
  it "should filter code" do
    CodeFilter.new.call("<code>puts 'hi'</code>").must_equal <<-eos
<div class="CodeRay">
  <div class="code"><pre>puts <span style="background-color:hsla(0,100%,50%,0.05)"><span style="color:#710">'</span><span style="color:#D20">hi</span><span style="color:#710">'</span></span></pre></div>
</div>
eos
  end
end

