class Bitmap
  attr_reader :matrix, :width, :height

  def initialize(w, h, default_value = nil)
    @width, @height = w, h
    @matrix = Array.new(size) { default_value }
  end

  def set_pixel(x, y, value)
    return if out_of_boundaries?(x, y)
    matrix[coordinates_to_index(x, y)] = value
  end

  def set_column(x, y1, y2, value)
    (y1..y2).each do |y|
      set_pixel(x, y, value)
    end
  end

  def set_row(x1, x2, y, value)
    (x1..x2).each do |x|
      set_pixel(x, y, value)
    end
  end

  def reset(value)
    matrix.map! { value }
  end

  def size
    width * height
  end

  def to_s
    mutli_dimmentional.map { |row| row.join(' ') }.join("\n")
  end

  private

  def mutli_dimmentional
    matrix.each_slice(width).to_a
  end

  def coordinates_to_index(x, y)
    ((y-1) * width) + (x-1)
  end

  def out_of_boundaries?(x,y)
    x > width || y > height
  end
end
