require_relative 'command'

class BitmapEditor
  attr_reader :commands

  def initialize
    @commands = {}

    register_command(:I, %i{M N}, 'Create a new M x N image with all pixels coloured white (O)', -> (m, n) {create_new_matrix(m, n)})
    register_command(:C, %i{}, 'Clears the table, setting all pixels to white (O)', -> {clear_matrix})
    register_command(:L, %i{X Y C}, 'Colours the pixel (X,Y) with colour C', -> (x, y, c) {colour_matrix_pixel(x, y, c)})
    register_command(:V, %i{X Y1 Y2 C}, 'Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)', -> (x, y1, y2, c) {colour_matrix_row(x, y1, y2, c)})
    register_command(:H, %i{X1 X2 Y C}, 'Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)', -> (x1, x2, y, c) {colour_matrix_column(x1, x2, y, c)})
    register_command(:S, %i{}, 'Show the contents of the current image', -> {show_matrix})
    register_command(:X, %i{}, 'Terminate the session', -> {exit_console})
    register_command(:'?', %i{}, 'Help', -> {show_help})
  end

  def run
    @running = true
    puts 'type ? for help'
    while @running
      print '> '

      args = gets.chomp.split(' ')
      cmd = @commands[args.shift]

      if cmd
        cmd.run(args)
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
      puts @commands.values.map(&:help).join("\n")
    end

    def register_command(cmd, arguments, description, executor)
      @commands[cmd.to_s] = Command.new(cmd, arguments, description, executor)
    end
end
