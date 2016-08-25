require './app/matrix'

class Bitmap < Matrix
  MIN_SIZE = 1
  MAX_SIZE = 250
  DEFAULT_COLOUR = 'O'

  def initialize(w, h)
    super(parse_size(w), parse_size(h), DEFAULT_COLOUR)
  end

  def reset
    super(DEFAULT_COLOUR)
  end

  private

    def valid_value?(value)
      value && value.size == 1 && /[[:upper:]]/.match(value)
    end

    def parse_size(size)
      [[MIN_SIZE, size].max, MAX_SIZE].min
    end
end
