require_relative 'utils/time_formatter'

class Actions
  def self.get_current_time(params = {})
    format = params['format']
    time_formatted = TimeFormatter.formating(Time.now, format)

    if time_formatted.success?
      Router.generate_response(
        status: :ok,
        body_content: time_formatted.value
      )
    else
      Router.generate_response(
        status: :bad_request,
        body_content: "Unknown time format \[#{time_formatted.errors}\]"
      )
    end
  end
end
