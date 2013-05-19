require './spec/test_helper.rb'

describe Middleware do

  let(:rendered_file){ 'index.html' }
  let(:template_file){ 'index.erb.html' }

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
    r.expect :files, [template_file]
    r.expect :render_file, true, [template_file]
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
