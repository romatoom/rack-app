require_relative 'router'

class App
  include Rack::Utils
  def call(env)
    router = Router.new

    request_method = env["REQUEST_METHOD"]
    request_path = env["REQUEST_PATH"]
    query_values = parse_query(env["QUERY_STRING"])

    router.get_response(request_method, request_path, query_values)
  rescue
    [
      status_code(:internal_server_error),
      { 'ContentType' => 'text/plain' },
      ["Internal Server Error"]
    ]
  end
end
