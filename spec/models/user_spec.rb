describe User do

  before(:each) { @user = User.new(email: 'user@example.com', password: '12345678', password_confirmation: '12345678') }

  subject { @user }

  it { should respond_to(:email) }
  it { should be_valid }

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

  describe "contact associations" do
    before { @user.save }
    let!(:david) do
      FactoryGirl.create(:contact, user: @user, name: 'David Beckham')
    end
    let!(:anna) do
      FactoryGirl.create(:contact, user: @user, name: 'Anna Kava')
    end
    let!(:thomas) do
      FactoryGirl.create(:contact, user: @user, name: 'Thomas Hooks')
    end
    it "should have the right contacts in A-Z order" do
      expect(@user.contacts.to_a).to eq [anna, david, thomas]
    end

  end


end
