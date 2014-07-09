require 'rails_helper'

RSpec.describe Contact, :type => :model do

  before do
    @user = FactoryGirl.create(:user)
    @contact = Contact.new(:name => "name", :phone => "18889086171", :email => "abc@example.com", :user_id => @user.id)
  end

  subject { @contact }

  it { should respond_to(:phone) }
  it { should respond_to(:name) }
  it { should respond_to(:email) }

  it { should respond_to(:user_id) }
  it { should respond_to(:user) }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @contact.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is not present" do
    before { @contact.name = nil }
    it { should_not be_valid }
  end

  describe "when email is not email-format" do
    before { @contact.email = "1234664"}
    it { should_not be_valid }
  end

  describe "when phone is not phone-format" do
    before { @contact.phone = "1212ab233"}
    it { should_not be_valid }
  end

  describe "should have a factory" do
    it { expect(FactoryGirl.build(:contact)).to be_valid}
  end
end
