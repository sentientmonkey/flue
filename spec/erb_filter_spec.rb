require "./spec/test_helper.rb"

describe ERBFilter do
  it "should filter erb" do
    ERBFilter.new.call("<p><%= 1 + 2 %></p>").must_equal "<p>3</p>"
  end

  it "should filter erb with variables" do
    ERBFilter.new.call("<p><%= @a + @b %></p>", :variables => {:a => 1, :b => 2}).must_equal "<p>3</p>"
  end

  it "should filter erb with partial" do
    basefile = MiniTest::Mock.new
    basefile.expect :exts, []
    basefile.expect :content, "test"
    basefile.expect :basename, "_test.html"
    logger = MiniTest::Mock.new
    logger.expect :info, true, [/_test\.html => partial/]
    Dir.stub :[], ["test"] do
      Basefile.stub :new, basefile do
        FilterRegister.stub :run, "<p>This is a test</p>" do
          erb_filter = ERBFilter.new
          erb_filter.stub :logger, logger do
            erb_filter.call("<%= partial :test %>").must_equal "<p>This is a test</p>"
          end
        end
      end
    end
  end
end

