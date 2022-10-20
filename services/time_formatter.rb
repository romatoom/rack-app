class TimeFormatter
  OPTIONS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  attr_reader :error_fields, :fields

  def initialize(time, format)
    @time, @format = time, format
    @fields = []
    @error_fields = []
  end

  def call
    all_fields = format.split(',')

    all_fields.each do |f|
      if OPTIONS.keys.include?(f)
        self.fields << time.strftime(OPTIONS[f])
      else
        self.error_fields << f
      end
    end

    self
  end

  def success?
    error_fields.length.zero?
  end

  def result
    fields.join('-')
  end

  def error
    error_fields.length > 0 ? "Unknown time format \[#{error_fields.join(', ')}\]" : nil
  end

  private

  attr_reader :time, :format
  attr_writer :error_fields, :fields
end
