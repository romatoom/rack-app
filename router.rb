require_relative "utils/time_formatter"

class Router
  include Rack::Utils

  ROUTES = [
    {
      name: 'time',
      method: 'GET',
      path: '/time',
      action: :get_current_time
    }
  ].freeze

  def initialize; end

  def get_response(method, request_path, query_values)
    route = find_route(method, request_path)
    return not_found_response if route.nil?

    self.send route[:action], query_values
  end

  private

  def find_route(method, request_path)
    ROUTES.find { |r| r[:method] == method && r[:path] == request_path }
  end

  def not_found_response
    [status_code(:not_found), headers, ["Not found!"]]
  end

  def headers
    { 'ContentType' => 'text/plain' }
  end

  def get_current_time(query_values = {})
    format = query_values["format"]
    time_formatted = TimeFormatter.formating(Time.now, format)

    error_fields = time_formatted[:error_fields]
    unless error_fields.nil?
      return [status_code(:bad_request), headers, ["Unknown time format \[#{error_fields.join(", ")}\]"]]
    end

    [status_code(:ok), headers, [time_formatted[:value]]]
  end
end
