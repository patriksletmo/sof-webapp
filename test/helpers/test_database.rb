require 'helpers/test_request'
require 'helpers/test_response'

class TestDatabase < Database
  def initialize
    super(AccessToken.dummy)
  end

  def get(url, options, *args)
    respond_to :get, url
  end

  def post(url, options, *args)
    respond_to :post, url
  end

  def put(url, options, *args)
    respond_to :put, url
  end

  def delete(url, options, *args)
    respond_to :delete, url
  end

  private

  def respond_to(method, url)
    body = read_response(method.to_s, url)
    Response.new(TestRequest.new, TestResponse.new, lambda { JSON.parse(body) }, body: body)
  end

  def read_response(method, url)
    File.read(url_path(method, url))
  end

  def url_path(method, url)
    File.join(responses_root, method, url.chomp('/') + '.json')
  end

  def responses_root
    File.expand_path('../../responses/', __FILE__)
  end
end