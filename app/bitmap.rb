class Bitmap
  attr_reader :matrix, :width, :height

  def initialize(w, h)
    @width, @height = w, h
    @matrix = Array.new(size) { 'O' }
  end

  def set_pixel(x, y, value)
    return if out_of_boundaries?(x, y)
    matrix[coordinates_to_index(x, y)] = value
  end

  def size
    width * height
  end

  private

  def coordinates_to_index(x, y)
    (x % width) + (width * y)
  end

  def out_of_boundaries?(x,y)
    x >= width || y >= height
  end
end
