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

  def cmd(editor, input)
    allow(editor).to receive_message_chain(:gets, :chomp) do
      p input
    end
  end

  describe 'run' do
    describe '? command' do
      before(:each) do
        one_off_cmd(subject, '?')
      end

      it 'outputs helps for I' do
        expect { subject.run }.to output(/I M N - Create a new M x N image with all pixels coloured white \(O\)\./).to_stdout
      end

      it 'outputs helps for C command' do
        expect { subject.run }.to output(/C - Clears the table, setting all pixels to white \(O\)\./).to_stdout
      end

      it 'outputs helps for L command' do
        expect { subject.run }.to output(/L X Y C - Colours the pixel \(X,Y\) with colour C\./).to_stdout
      end

      it 'outputs helps for V command' do
        expect { subject.run }.to output(/V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 \(inclusive\)\./).to_stdout
      end

      it 'outputs helps for H command' do
        expect { subject.run }.to output(/H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 \(inclusive\)\./).to_stdout
      end

      it 'outputs helps for S command' do
        expect { subject.run }.to output(/S - Show the contents of the current image/).to_stdout
      end

      it 'outputs helps for X command' do
        expect { subject.run }.to output(/X - Terminate the session/).to_stdout
      end
    end

    describe 'X command' do
      before(:each) do
        cmd(subject, 'X')
      end

      it 'outputs goodbye message and exists loop' do
        expect { subject.run }.to output(/goodbye!/).to_stdout
      end
    end

    describe 'unknown command' do
      before(:each) do
        one_off_cmd(subject, 'undefined')
      end

      it 'outputs `unrecognised command :(`' do
        expect { subject.run }.to output(/unrecognised command :\(/).to_stdout
      end
    end
  end
end
