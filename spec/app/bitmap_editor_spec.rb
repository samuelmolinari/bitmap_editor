require 'spec_helper'
require_relative '../../app/bitmap_editor'

describe BitmapEditor do
  subject { described_class.new }

  def one_off_cmd(editor, input)
    allow(editor).to receive_message_chain(:gets, :chomp) do
      subject.instance_variable_set(:@running, false)
      input
    end
  end

  def cmd(editor, input)
    allow(editor).to receive_message_chain(:gets, :chomp) do
      input
    end
  end

  describe 'run' do
    describe 'I command' do
      it 'creates a new matrix of size MxN' do
        one_off_cmd(subject, 'I M N')
        expect(subject).to receive(:create_new_matrix).with('M', 'N')

        subject.run
      end

      xit 'output an error when the M or N values are not between 1 and 250'
    end

    describe 'C command' do
      it 'clears matrix' do
        one_off_cmd(subject, 'C')
        expect(subject).to receive(:clear_matrix)

        subject.run
      end
    end

    describe 'L command' do
      it 'colours pixel' do
        one_off_cmd(subject, 'L X Y C')
        expect(subject).to receive(:colour_matrix_pixel).with('X', 'Y', 'C')

        subject.run
      end

      xit 'output an error when the C value is not a capital letter'
    end

    describe 'V command' do
      it 'colours matrix row' do
        one_off_cmd(subject, 'V X Y1 Y2 C')
        expect(subject).to receive(:colour_matrix_row).with('X', 'Y1', 'Y2', 'C')

        subject.run
      end

      xit 'output an error when the C value is not a capital letter'
    end

    describe 'H command' do
      it 'colours matrix row' do
        one_off_cmd(subject, 'H X1 X2 Y C')
        expect(subject).to receive(:colour_matrix_column).with('X1', 'X2', 'Y', 'C')

        subject.run
      end

      xit 'output an error when the C value is not a capital letter'
    end

    describe 'S command' do
      it 'shows the matrix' do
        one_off_cmd(subject, 'S')
        expect(subject).to receive(:show_matrix)

        subject.run
      end
    end

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
