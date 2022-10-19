require_relative 'utils/time_formatter'

class App
  include Rack::Utils

  def call(env)
    req = Rack::Request.new(env)
    get_response(req).finish
  rescue
    generate_response(status: :internal_server_error, body_content: 'Internal Server Error').finish
  end

  private

  def get_response(request)
    if request.request_method == 'GET' && request.path == '/time'
      get_current_time(request.params)
    else
      generate_response(status: :not_found, body_content: 'Not found!')
    end
  end

  def get_current_time(params = {})
    format = params['format']

    time_formatted = TimeFormatter.new
    time_formatted.formating(Time.now, format)

    if time_formatted.success?
      generate_response(
        status: :ok,
        body_content: time_formatted.fields.join('-')
      )
    else
      generate_response(
        status: :bad_request,
        body_content: "Unknown time format \[#{time_formatted.errors.join(', ')}\]"
      )
    end
  end

  def generate_response(status:, body_content:, headers: { 'ContentType' => 'text/plain' })
    Rack::Response.new([body_content], status_code(status), headers)
  end
end
