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
        one_off_cmd(subject, 'I 2 3')

        subject.run

        expect(subject.bitmap.width).to eq 2
        expect(subject.bitmap.height).to eq 3
      end

      xit 'output an error when the M or N values are not between 1 and 250'
    end

    describe 'C command' do
      context 'with bitmap' do
        let(:bitmap) { Bitmap.new(3,3) }

        before(:each) do
          allow(subject).to receive(:bitmap) { bitmap }
        end

        it 'clears matrix' do
          one_off_cmd(subject, 'C')

          expect(subject.bitmap).to receive(:reset).with('O')

          subject.run
        end
      end

      context 'without bitmap' do
        it 'warns the user a bitmap needs creating with the command help' do
          one_off_cmd(subject, 'C')
          expect { subject.run }.to output(/I M N - Create a new M x N image with all pixels coloured white \(O\)\./).to_stdout
        end
      end
    end

    describe 'L command' do
      context 'with bitmap' do
        let(:bitmap) { Bitmap.new(3,3) }

        before(:each) do
          allow(subject).to receive(:bitmap) { bitmap }
        end

        it 'colours pixel' do
          one_off_cmd(subject, 'L 1 2 C')

          expect(subject.bitmap).to receive(:set_pixel).with(1, 2, 'C')

          subject.run
        end
      end

      context 'without bitmap' do
        it 'warns the user a bitmap needs creating with the command help' do
          one_off_cmd(subject, 'L 1 2 C')
          expect { subject.run }.to output(/I M N - Create a new M x N image with all pixels coloured white \(O\)\./).to_stdout
        end
      end

      xit 'output an error when the C value is not a capital letter'
    end

    describe 'V command' do
      context 'with bitmap' do
        let(:bitmap) { Bitmap.new(3,3) }

        before(:each) do
          allow(subject).to receive(:bitmap) { bitmap }
        end

        it 'colours matrix column' do
          one_off_cmd(subject, 'V 1 2 3 C')
          expect(subject.bitmap).to receive(:set_column).with(1, 2, 3, 'C')

          subject.run
        end
      end

      xit 'output an error when the C value is not a capital letter'

      context 'without bitmap' do
        xit 'warns the user a bitmap needs creating with the command help'
      end
    end

    describe 'H command' do
      context 'with bitmap' do
        let(:bitmap) { Bitmap.new(3,3) }

        before(:each) do
          allow(subject).to receive(:bitmap) { bitmap }
        end

        it 'colours matrix row' do
          one_off_cmd(subject, 'H 1 2 3 C')
          expect(subject.bitmap).to receive(:set_row).with(1, 2, 3, 'C')

          subject.run
        end
      end

      xit 'output an error when the C value is not a capital letter'

      context 'without bitmap' do
        xit 'warns the user a bitmap needs creating with the command help'
      end
    end

    describe 'S command' do
      context 'with bitmap' do
        let(:bitmap) { Bitmap.new(3,3) }

        before(:each) do
          allow(subject).to receive(:bitmap) { bitmap }
        end

        it 'outputs the matrix' do
          one_off_cmd(subject, 'S')
          expect { subject.run }.to output(/#{subject.bitmap.to_s}/).to_stdout

          subject.run
        end
      end

      context 'without bitmap' do
        xit 'warns the user a bitmap needs creating with the command help'
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
