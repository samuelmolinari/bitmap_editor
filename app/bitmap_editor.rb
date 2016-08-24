class BitmapEditor

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '

      args = gets.chomp.split(' ')
      cmd = args.shift

      case cmd
        when 'I'
          create_new_matrix(*args)
        when 'C'
          clear_matrix
        when 'L'
          colour_matrix_pixel(*args)
        when 'V'
          colour_matrix_row(*args)
        when 'H'
          colour_matrix_column(*args)
        when 'S'
          show_matrix
        when '?'
          show_help
        when 'X'
          exit_console
        else
          unknown_command
      end
    end
  end

  private
    def create_new_matrix(m,n)
    end

    def clear_matrix
    end

    def colour_matrix_pixel(x, y, c)
    end

    def colour_matrix_row(x, y1, y2, c)
    end

    def colour_matrix_column(x1, x2, y, c)
    end

    def show_matrix
    end

    def unknown_command
      puts 'unrecognised command :('
    end

    def exit_console
      puts 'goodbye!'
      @running = false
    end

    def show_help
      puts "? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session"
    end
end
