#!/usr/bin/env ruby

require "minitest/spec"
require "minitest/mock"
require "minitest/autorun"
require "minitest/pride"
require 'sitegen'

include Sitegen

describe Basefile do
  let(:md_erb) do
    Basefile.new("site/test.md.erb.html")
  end

  it "should have basename" do
    md_erb.basename.must_equal "test.md.erb.html"
  end

  it "should have parts" do
    md_erb.parts.must_equal ["test","md","erb", "html"]
  end

  it "should have exts" do
    md_erb.exts.must_equal ["md","erb"]
  end

  it "should have dirname" do
    md_erb.dirname.must_equal "site"
  end

  it "should have outfile_basename" do
    md_erb.outfile_basename.must_equal "test.html"
  end

  it "should have outfile_name" do
    md_erb.outfile_name.must_equal "_site/test.html"
  end
end

describe MarkdownFilter do
  it "should filter markdown" do
    MarkdownFilter.filter("# Foo").must_equal "<h1 id='foo'>Foo</h1>"
  end
end

describe TextileFilter do
  it "should filter textile" do
    TextileFilter.filter("h1. Just a test").must_equal "<h1>Just a test</h1>"
  end
end

describe ERBFilter do
  it "should filter erb" do
    ERBFilter.filter("<p><%= 1 + 2 %></p>").must_equal "<p>3</p>"
  end
end

describe EmojiFilter do
  it "should filter emoji" do
    FileUtils.stub :mkdir_p, true do
      FileUtils.stub :cp, true do
        EmojiFilter.filter(":poop:").must_equal '<img alt="poop" height="20" src="images/emoji/poop.png" style="vertical-align:middle" width="20" />'
      end
    end
  end

describe SassFilter do
  it "should filter sass" do
    SassFilter.filter("table.h1{ td.ln { font: { color: red; } } }").must_equal "table.h1 td.ln {\n  font-color: red; }\n"
  end
end

end

