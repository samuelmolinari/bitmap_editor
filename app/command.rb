class Command
  attr_reader :cmd, :arguments, :description, :executor

  def initialize(cmd, arguments, description, executor)
    @cmd, @arguments, @description, @executor = cmd, arguments, description, executor
  end

  def run(args = [])
    return invalid unless valid?(args)
    executor.call(*args)
  end

  def help
    "#{cmd}#{arguments.any? ? ' ' + arguments.join(' ') : ''} - #{description}."
  end

  private

  def invalid
      puts "Error! Invalid number of arguments."
      puts "Help for #{cmd}:"
      puts help
  end

  def valid?(args)
    arguments.size == args.size
  end
end
