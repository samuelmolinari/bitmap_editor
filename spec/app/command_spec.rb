require 'spec_helper'
require './app/command'

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

    context 'when unexpected error occurs' do
      it 'ouputs the exception message' do
        allow(subject.executor).to receive(:call) { fail 'test' }
        expect { subject.run([1,2]) }.to output(/Unexpected error/).to_stdout
        expect { subject.run([1,2]) }.to output(/test/).to_stdout
      end
    end
  end
end

