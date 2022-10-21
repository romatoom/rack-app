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

  def initialize(format)
    @format = format
    @time_now = Time.now
  end

  def call
    all_fields = format.split(',')

    fields = []
    error_fields = []

    all_fields.each do |f|
      if OPTIONS.keys.include?(f)
        fields << time_now.strftime(OPTIONS[f])
      else
        error_fields << f
      end
    end

    TimeFormatterResult.new(fields: fields, error_fields: error_fields)
  end

  private

  attr_reader :time_now, :format
end
