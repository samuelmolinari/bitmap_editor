require_relative 'command'

module Runnable
  def run
    start
    puts 'type ? for help'

    while @running
      print '> '

      args = gets.chomp.split(' ')
      cmd = commands[args.shift]

      if cmd
        cmd.run(args)
      else
        unknown_command
      end
    end
  end

  def start
    @running = true
  end

  def exit_console
    @running = false
  end

  def commands
    {}
  end

  def unknown_command
    puts 'unrecognised command :('
  end

  def register_command(cmd, arguments, description, executor)
    commands[cmd.to_s] = Command.new(cmd, arguments, description, executor)
  end

  def show_help
    puts commands.values.map(&:help).join("\n")
  end
end
