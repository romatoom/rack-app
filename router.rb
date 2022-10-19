require_relative 'actions'

class Router
  extend Rack::Utils

  ROUTES = {
    'GET' => {
      '/time' => :get_current_time
    }
  }

  def self.get_response(request)
    request_method = request.request_method
    request_path = request.path
    request_params = request.params

    route_action = Router.find_route_action(request_method, request_path)
    return Router.generate_response(status: :not_found, body_content: 'Not found!') if route_action.nil?

    Actions.send(route_action, request_params)
  end

  def self.generate_response(status:, body_content:, headers: { 'ContentType' => 'text/plain' })
    Rack::Response.new([body_content], status_code(status), headers)
  end

  private

  def self.find_route_action(request_method, request_path)
    ROUTES[request_method][request_path]
  end

end
