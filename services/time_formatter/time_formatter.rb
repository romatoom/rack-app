require_relative 'time_formatter_result'

class TimeFormatter
  OPTIONS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  def initialize(time, format)
    @time, @format = time, format
  end

  def call
    all_fields = format.split(',')

    fields = []
    error_fields = []

    all_fields.each do |f|
      if OPTIONS.keys.include?(f)
        fields << time.strftime(OPTIONS[f])
      else
        error_fields << f
      end
    end

    TimeFormatterResult.new(fields: fields, error_fields: error_fields)
  end

  private

  attr_reader :time, :format
end
