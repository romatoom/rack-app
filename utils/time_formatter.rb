class TimeFormatter
  OPTIONS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  TimeFormatterResult = Struct.new(:value, :errors) do
    def success?
      errors.length.zero?
    end
  end

  def self.formating(time, format = 'year,month,day')
    fields = format.split(',')

    error_fields = []
    formatted_fields = []

    fields.each do |f|
      if OPTIONS.keys.include?(f)
        formatted_fields << time.strftime(OPTIONS[f])
      else
        error_fields << f
      end
    end

    TimeFormatterResult.new(formatted_fields.join('-'), error_fields.join(', '))
  end
end
