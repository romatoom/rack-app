require_relative 'router'

class App
  include Rack::Utils
  def call(env)
    req = Rack::Request.new(env)
    Router.get_response(req).finish
  rescue
    Router.generate_response(status: :internal_server_error, body_content: 'Internal Server Error').finish
  end
end
