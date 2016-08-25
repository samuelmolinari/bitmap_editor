require 'spec_helper'
require_relative '../app/command'

describe 'Technical Test Ruby developer example' do
  let(:commands) { ['I 5 6', 'L 2 3 A', 'S', 'V 2 3 6 W', 'H 3 5 2 Z', 'S', 'X'] }

  before do
    allow_any_instance_of(Kernel).to receive(:gets) do
      puts cmd = commands.shift
      cmd
    end
  end

  it 'executes as described in the requirements' do
    expect { load './runner.rb' }.to output("
      type ? for help
      > I 5 6
      > L 2 3 A
      > S
      OOOOO
      OOOOO
      OAOOO
      OOOOO
      OOOOO
      OOOOO
      > V 2 3 6 W
      > H 3 5 2 Z
      > S
      OOOOO
      OOZZZ
      OWOOO
      OWOOO
      OWOOO
      OWOOO
      > X
      goodbye!
    ".gsub(/\n +/, "\n").gsub(/^\n/, '')).to_stdout
  end
end
