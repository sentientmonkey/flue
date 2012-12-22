require './spec/test_helper.rb'

describe Middleware do

  RENDERED_FILE = 'index.html'
  TEMPLATE_FILE = 'index.erb.html'

  let(:middleware) do
    Middleware.new(app, watcher, runner)
  end

  let(:app) do
    a = MiniTest::Mock.new
    a.expect :call, true, [env]
    a
  end

  let(:watcher) do
    w = MiniTest::Mock.new
    w.expect :changes, [TEMPLATE_FILE]
    w
  end

  let(:runner) do
    r = MiniTest::Mock.new
    r.expect :files, [TEMPLATE_FILE]
    r.expect :render_file, true, [TEMPLATE_FILE]
    r
  end

  let(:env) do
    e = MiniTest::Mock.new
    e.expect :[], RENDERED_FILE, ['PATH_INFO']
    e
  end

  it "should re-render changed files" do
    middleware.call(env)
  end

end
