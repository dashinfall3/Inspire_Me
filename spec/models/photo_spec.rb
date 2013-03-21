require 'spec_helper'

describe Photo do
  
  it { should have_db_column(:caption) }
  it { should have_db_column(:image) }
  it { should respond_to(:caption) }
  it { should respond_to(:image) }

  it { should ensure_length_of(:caption).is_at_most(140) }

  it { should belong_to(:inspiration)}
  it { should belong_to(:user) }

end
