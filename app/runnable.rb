require_relative 'command'

module Runnable
  def run
    start

    while @running
      print '> '
      handle_input
    end
  end

  def handle_input
    args = gets.chomp.split(' ')
    cmd = commands[args.shift]

    if cmd
      cmd.run(args)
    else
      unknown_command
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
