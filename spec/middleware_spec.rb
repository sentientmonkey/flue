require './spec/test_helper.rb'

describe Middleware do

  let(:rendered_file){ 'index.html' }
  let(:template_file){ 'index.erb.html' }
  let(:basefile){ Basefile.new(template_file) }

  let(:middleware) do
    Middleware.new(app, watcher, renderer)
  end

  let(:app) do
    a = MiniTest::Mock.new
    a.expect :call, true, [env]
    a
  end

  let(:watcher) do
    w = MiniTest::Mock.new
    w.expect :changes, [template_file]
    w
  end

  let(:renderer) do
    r = MiniTest::Mock.new
    r.expect :basefiles, [basefile]
    r.expect :render_file, true, [basefile]
    r
  end

  let(:env) do
    e = MiniTest::Mock.new
    e.expect :[], rendered_file, ['PATH_INFO']
    e
  end

  it "should re-render changed files" do
    middleware.call(env)
  end

end
