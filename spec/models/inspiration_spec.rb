require 'spec_helper'

describe Inspiration do
  let(:inspiration) {Inspiration.new(:content => "whatup everybody you should be inspired")}

  context 'creating new inspiration' do
    it 'instantiates an inspiration' do
      inspiration.is_a?(Inspiration).should be_true
    end

    it 'accepts a string' do
      Inspiration.new.should allow_value("hey").for(:content)
    end

    it 'does not accept content over 140 characters' do
      before { inspiration.content = "a" * 150}
      it { should_not be_valid }
    end

    it 'cannot be created without content' do
      Inspiration.new.should_not allow_value(nil).for(:content)
    end

    it 'has content' do
      inspiration.content.should eq('whatup everybody you should be inspired')
    end

    it 'has unique content' do
      expect {
        Inspiration.new(:content => "whatup everybody you should be inspired")
      }.to raise_error
    end


  end

  context "has correct model associations" do
    it { should have_many(:photos) }
  end


end




# #inspirations
# x It accepts a string as input

# x It does not allow content longer than 140 characters

# It should not allow inspirations with duplicate content

# x It requires content to be present

# x It inspiration has content




