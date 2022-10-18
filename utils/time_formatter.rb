class TimeFormatter
  AVAILABLE_FORMATS = %w(year month day hour minute second).freeze

  OPTIONS = {
    "year" => '%Y',
    "month" => '%m',
    "day" => '%d',
    "hour" => '%H',
    "minute" => '%M',
    "second" => '%S'
  }

  def self.formating(time, format = 'year,month,day')
    fields = format.split(",")

    error_fields = fields.find_all {|f| !AVAILABLE_FORMATS.include?(f)}
    return { error_fields: error_fields } unless error_fields.length.zero?

    fields.map! {|f| time.strftime(OPTIONS[f]) }

    { value: fields.join("-") }
  end
end
