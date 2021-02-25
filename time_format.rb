class TimeFormat

  FORMATS = { year: '%Y', month: '%m', day: '%d', hour: '%H', minute: '%M', second: '%S' }.freeze

  def initialize(params)
    @params = params.split(',')
    @time_string = []
    @invalid_format = []
  end

  def call
    @params.each do |format|
      if FORMATS.key?(format.to_sym)
        @time_string << FORMATS[format.to_sym]
      else
        @invalid_format << format
      end
    end
  end

  def success?
    @invalid_format.empty?
  end

  def time_text
    Time.now.strftime(@time_string.join('-'))
  end

  def invalid_params
    "Unknown time format #{@invalid_format.join(', ')}"
  end
end
