class TimeFormatterResult
  def initialize(fields:, error_fields:)
    @fields, @error_fields = fields, error_fields
  end

  def result
    fields.join('-')
  end

  def error_message
    error_fields.length > 0 ? "Unknown time format \[#{error_fields.join(', ')}\]" : nil
  end

  def success?
    error_fields.length.zero?
  end

  private

  attr_reader :fields, :error_fields
end
