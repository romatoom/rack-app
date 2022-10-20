require_relative 'services/time_formatter'

class TimeApp
  include Rack::Utils

  def call(env)
    request = Rack::Request.new(env)
    set_current_time_response(request).finish
  end

  private

  def set_current_time_response(request)
    if (format = get_format_parametr(request)).nil?
      return generate_response(
        status: :bad_request,
        body_content: 'Invalid query parameters!'
      )
    end

    time_formatted = TimeFormatter.new(Time.now, format).call

    if time_formatted.success?
      generate_response(status: :ok, body_content: time_formatted.result)
    else
      generate_response(status: :bad_request, body_content: time_formatted.error)
    end
  end

  def get_format_parametr(request)
    request.params['format']
  rescue
  end

  def generate_response(status:, body_content:)
    Rack::Response.new([body_content], status_code(status))
  end
end
