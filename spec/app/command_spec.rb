require 'spec_helper'
require_relative '../../app/command'

describe Command do
  subject { described_class.new(:test, %i{a b}, 'test lambda', -> (a,b) { a + b }) }

  describe '#run' do
    context 'when valid' do
      it 'calls the lambda with arguments' do
        expect(subject.run([1,2])).to eq 3
      end
    end

    context 'when invalid' do
      it 'outputs error and display the help for that command' do
        expect { subject.run([1,2,3]) }.to output(/Error/).to_stdout
        expect { subject.run([1,2,3]) }.to output(/#{subject.help}/).to_stdout
      end
    end
  end
end

