require 'spec_helper'
require_relative '../../app/matrix'

describe Matrix do
  let(:width) { 2 }
  let(:height) { 3 }

  subject { described_class.new(width, height, 'O') }

  describe '#initialize' do
    it 'creates a bitmap of size MxN' do
      expect(subject.size).to eq 6
    end

    it 'has a width of M' do
      expect(subject.width).to eq width
    end

    it 'has a height of N' do
      expect(subject.height).to eq height
    end

    it 'creates a matrix containing Os' do
      expect(subject.matrix).to eq ['O', 'O', 'O', 'O', 'O', 'O']
    end
  end

  describe '#reset' do
    before(:each) do
      subject.set_pixel(1, 1, '1_1')
      subject.set_pixel(2, 2, '2_2')
      subject.set_pixel(2, 3, '2_3')
    end

    it 'sets all the values to the given value' do
      subject.reset('O')

      expect(subject.matrix).to eq ['O', 'O', 'O', 'O', 'O', 'O']
    end
  end

  describe '#set_column' do
    it 'set value to a given column x and between rows y1 and y2' do
      subject.set_column(1, 2, 3, 'C')
      expect(subject.matrix).to eq ['O', 'O', 'C', 'O', 'C', 'O']
    end

    context 'when y1 is greater than y2' do
      it 'does not change the matrix' do
        subject.set_column(1, 3, 2, 'C')
        expect(subject.matrix).to eq ['O', 'O', 'O', 'O', 'O', 'O']
      end
    end
  end

  describe '#set_row' do
    it 'set value to a given row y and between columns x1 and x2' do
      subject.set_row(1, 2, 3, 'C')
      expect(subject.matrix).to eq ['O', 'O', 'O', 'O', 'C', 'C']
    end

    context 'when x1 is greater than x2' do
      it 'does not change the matrix' do
        subject.set_row(2, 1, 3, 'C')
        expect(subject.matrix).to eq ['O', 'O', 'O', 'O', 'O', 'O']
      end
    end
  end

  describe '#set_pixel' do
    it 'set value at given coordinate x,y' do
      subject.set_pixel(1, 1, '1_1')
      subject.set_pixel(1, 2, '1_2')
      subject.set_pixel(1, 3, '1_3')
      subject.set_pixel(2, 1, '2_1')
      subject.set_pixel(2, 2, '2_2')
      subject.set_pixel(2, 3, '2_3')

      expect(subject.matrix).to eq ['1_1', '2_1', '1_2', '2_2', '1_3', '2_3']
    end

    context 'when setting a value out of the matrix boundaries' do
      it 'does not affect the matrix' do
        subject.set_pixel(4, 4, '4_4')
        expect(subject.matrix).to eq ['O', 'O', 'O', 'O', 'O', 'O']
      end
    end
  end

  describe '#to_s' do
    it 'generates a string representing the matrix' do
      subject.set_pixel(1, 1, 'A')
      subject.set_pixel(2, 1, 'B')
      subject.set_pixel(1, 2, 'C')
      subject.set_pixel(2, 2, 'D')
      subject.set_pixel(1, 3, 'E')
      subject.set_pixel(2, 3, 'F')

      expect(subject.to_s).to eq("AB\nCD\nEF")
    end
  end
end

