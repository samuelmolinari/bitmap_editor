require 'spec_helper'
require_relative '../../app/bitmap_editor'

describe BitmapEditor do
  subject { described_class.new }

  def one_off_cmd(editor, input)
    allow(editor).to receive_message_chain(:gets, :chomp) do
      subject.instance_variable_set(:@running, false)
      p input
    end
  end

  describe 'run' do
    describe '? command' do
      before(:each) do
        one_off_cmd(subject, '?')
      end

      it 'shows help' do
        expect(subject).to receive(:show_help)
        subject.run
      end
    end

    describe 'X command' do
      before(:each) do
        one_off_cmd(subject, 'X')
      end

      it 'exists console' do
        expect(subject).to receive(:exit_console)
        subject.run
      end
    end

    describe 'unknown command' do
      before(:each) do
        one_off_cmd(subject, 'undefined')
      end

      it 'outputs `unrecognised command :(`' do
        expect(subject).to receive(:unknown_command)
        subject.run
      end
    end
  end
end
