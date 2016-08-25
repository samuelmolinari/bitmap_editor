require './app/bitmap'
require './app/runnable'

class BitmapEditor
  include Runnable

  attr_reader :commands, :bitmap

  def initialize
    @commands = {}
    @bitmap = nil

    register_commands
  end

  private

    def create_new_matrix(m,n)
      @bitmap = Bitmap.new(m.to_i, n.to_i)
    end

    def clear_matrix
      run_bitmap_command(:reset)
    end

    def colour_matrix_pixel(x, y, c)
      run_bitmap_command(:set_pixel, x.to_i, y.to_i, c)
    end

    def colour_matrix_column(x, y1, y2, c)
      run_bitmap_command(:set_column, x.to_i, y1.to_i, y2.to_i, c)
    end

    def colour_matrix_row(x1, x2, y, c)
      run_bitmap_command(:set_row, x1.to_i, x2.to_i, y.to_i, c)
    end

    def show_matrix
      puts run_bitmap_command(:to_s)
    end

    def start_message
      'type ? for help'
    end

    def exit_message
      'goodbye!'
    end

    def bitmap_missing_warning
      puts "Error: No bitmap has been created. \n#{commands['I'].help}"
    end

    def run_bitmap_command(method, *args)
      return bitmap_missing_warning unless bitmap
      bitmap.send(method, *args)
    end

    def register_commands
      register_command :I,
        %i{M N},
        'Create a new M x N image with all pixels coloured white (O)',
        :create_new_matrix

      register_command :C,
        %i{},
        'Clears the table, setting all pixels to white (O)',
        :clear_matrix

      register_command :L,
        %i{X Y C},
        'Colours the pixel (X,Y) with colour C',
        :colour_matrix_pixel

      register_command :V,
        %i{X Y1 Y2 C},
        'Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)',
        :colour_matrix_column

      register_command :H,
        %i{X1 X2 Y C},
        'Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)',
        :colour_matrix_row

      register_command :S,
        %i{},
        'Show the contents of the current image',
        :show_matrix

      register_command :X,
        %i{},
        'Terminate the session',
        :exit_console

      register_command :'?',
        %i{},
        'Help',
        :show_help
    end
end
