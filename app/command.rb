class Command
  attr_reader :cmd, :arguments, :description, :executor

  def initialize(cmd, arguments, description, executor)
    @cmd, @arguments, @description, @executor = cmd, arguments, description, executor
  end

  def run(args = [])
    return invalid unless valid?(args)
    begin
      executor.call(*args)
    rescue => e
      puts "Unexpected error: #{e.message}"
      puts help
    end
  end

  def help
    "#{cmd}#{arguments.any? ? ' ' + arguments.join(' ') : ''} - #{description}."
  end

  private

    def invalid
      puts "Error: Invalid number of arguments"
      puts help
    end

    def valid?(args)
      arguments.size == args.size
    end
end
