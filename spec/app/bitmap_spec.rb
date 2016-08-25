require 'spec_helper'
require './app/bitmap'

describe Bitmap do
  subject { described_class.new(2,3) }

  it { expect(described_class).to be < Matrix }

  describe '#initialize' do
    it 'initialise a matrix with its default value' do
      expect(subject.matrix).to eq Array.new(subject.size, described_class::DEFAULT_COLOUR)
    end

    it 'automatically resize the matrix if the sizes do not follow the requirements' do
      expect(described_class.new(251, 1).width).to eq 250
      expect(described_class.new(0, 1).width).to eq 1

      expect(described_class.new(1, 251).height).to eq 250
      expect(described_class.new(1, 0).height).to eq 1
    end
  end

  describe '#set_pixel' do
    it 'does not update the matrix when value is not a capital letter' do
      subject.set_pixel(1,1,1)
      expect(subject.matrix.first).to eq 'O'
      subject.set_pixel(1,1,'a')
      expect(subject.matrix.first).to eq 'O'
      subject.set_pixel(1,1,'A')
      expect(subject.matrix.first).to eq 'A'
    end
  end

  describe '#reset' do
    before(:each) do
      subject.set_pixel(1, 2, nil)
    end

    it 'reset the matrix with its default value' do
      subject.reset
      expect(subject.matrix).to eq Array.new(subject.size, described_class::DEFAULT_COLOUR)
    end
  end
end
