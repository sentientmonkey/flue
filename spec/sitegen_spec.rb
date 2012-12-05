#!/usr/bin/env ruby

require "minitest/spec"
require "minitest/autorun"
require "minitest/pride"
require 'sitegen'

include Sitegen

describe Basefile do
  let(:md_erb) do
    Basefile.new("site/test.md.erb")
  end

  it "should have basename" do
    md_erb.basename.must_equal "test.md.erb"
  end

  it "should have parts" do
    md_erb.parts.must_equal ["test","md","erb"]
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

describe ERBFilter do
  it "should filter erb" do
    ERBFilter.filter("<p><%= 1 + 2 %></p>").must_equal "<p>3</p>"
  end
end

