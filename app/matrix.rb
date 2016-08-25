class Matrix
  attr_reader :matrix, :width, :height

  def initialize(w, h, default_value = nil)
    @width, @height = w, h
    @matrix = Array.new(size) { default_value }
  end

  def set_pixel(x, y, value)
    return if out_of_boundaries?(x, y) || !valid_value?(value)
    matrix[coordinates_to_index(x, y)] = value
  end

  def set_column(x, y1, y2, value)
    return unless y1 < y2

    (y1..y2).each do |y|
      set_pixel(x, y, value)
    end
  end

  def set_row(x1, x2, y, value)
    return unless x1 < x2

    (x1..x2).each do |x|
      set_pixel(x, y, value)
    end
  end

  def reset(value)
    matrix.fill(value)
  end

  def size
    width * height
  end

  def to_s
    matrix.join.scan(/.{#{width}}/).join("\n")
  end

  private

    def valid_value?(value)
      true
    end

    def coordinates_to_index(x, y)
      ((y-1) * width) + (x-1)
    end

    def out_of_boundaries?(x,y)
      x > width || y > height
    end
end
