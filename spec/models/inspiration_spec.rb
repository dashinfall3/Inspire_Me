require 'spec_helper'

describe Inspiration do

  it { should have_db_column(:content) }
  it { should respond_to(:content) }

  it { should validate_presence_of(:content) }
  it { should ensure_length_of(:content).is_at_most(140) }

  it { should have_many(:photos) }

  context 'has unique content' do
    let(:inspiration) { create :inspiration }
    it { should validate_uniqueness_of(:content) }
  end


end
