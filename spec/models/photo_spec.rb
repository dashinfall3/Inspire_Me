require 'spec_helper'

describe Photo do

  let(:photo) {Photo.new(:caption => "sunset")}

  context 'creating new photos' do

    it { should respond_to(:caption) }

    it {should respond_to(:image) }

    it 'does not accept captions over 140 characters' do
      photo.caption = "a" * 150
      photo.should_not be_valid
    end
  end

  context 'has correct model associations' do
    it {should belong_to(:inspiration)}
  end
end
