require "./spec/test_helper.rb"

describe EmojiFilter do
  it "should filter emoji" do
    FileUtils.stub :mkdir_p, true do
      FileUtils.stub :cp, true do
        EmojiFilter.new.call(":poop:").must_equal '<img alt="poop" height="20" src="images/emoji/poop.png" style="vertical-align:middle" width="20" />'
      end
    end
  end

  it "should not filter invalid emoji names" do
    EmojiFilter.new.call(":unicornsprinkles:").must_equal ":unicornsprinkles:"
  end
end
