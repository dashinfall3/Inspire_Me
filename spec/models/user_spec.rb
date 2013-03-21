require 'spec_helper'

describe User do
  
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }

  it { should validate_confirmation_of(:password) }
  it { should ensure_length_of(:password).is_at_least(8) }
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should allow_value("omar@omar.com").for(:email) }
  it { should_not allow_value("blah").for(:email) }

  it { should have_many(:photos) }

  context 'user needs to be in db' do
    let!(:user) { create :user }
    it { should validate_uniqueness_of(:email) }  
  end

  context 'after save' do 
    let(:user) { create :user, { :email => 'CAP@email.com' } }
    it 'should not save the email with capital letter' do
      user.email.should_not match(/[A-Z]/)
    end
  end

end
