class TimeFormatter
  OPTIONS = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }

  attr_reader :errors, :fields

  def success?
    errors.length.zero?
  end

  def formating(time, format = 'year,month,day')
    self.fields = []
    self.errors = []

    all_fields = format.split(',')

    all_fields.each do |f|
      if OPTIONS.keys.include?(f)
        self.fields << time.strftime(OPTIONS[f])
      else
        self.errors << f
      end
    end
  end

  private

  attr_writer :errors, :fields
end
