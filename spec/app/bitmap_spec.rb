require 'spec_helper'
require_relative '../../app/bitmap'

describe Bitmap do
  let(:width) { 2 }
  let(:height) { 3 }

  subject { described_class.new(width, height) }

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
      expect(subject.matrix).to match_array ['O', 'O', 'O', 'O', 'O', 'O']
    end
  end

  describe '#set_pixel' do
    it 'set value at given coordinate x,y' do
      subject.set_pixel(0, 0, '0_0')
      subject.set_pixel(1, 1, '1_1')
      subject.set_pixel(1, 2, '1_2')

      expect(subject.matrix).to match_array ['0_0', 'O', 'O', '1_1', 'O', '1_2']
    end

    context 'when setting a value out of the matrix boundaries' do
      it 'does not affect the matrix' do
        subject.set_pixel(3, 3, '3_3')
        expect(subject.matrix).to match_array ['O', 'O', 'O', 'O', 'O', 'O']
      end
    end
  end
end

