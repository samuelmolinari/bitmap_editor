require './app/matrix'

class Bitmap < Matrix
  DEFAULT_COLOUR = 'O'
  MAX_SIZE = 250

  def initialize(w, h)
    super(parse_size(w), parse_size(h), DEFAULT_COLOUR)
  end

  def reset
    super(DEFAULT_COLOUR)
  end

  def valid_value?(value)
    value && value.size == 1 && /[[:upper:]]/.match(value)
  end

  private

  def parse_size(size)
    [[1, size].max, MAX_SIZE].min
  end
end
