require 'spec_helper'

describe "Contact index page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:c1) { FactoryGirl.create(:contact, :user => user, :name => "Foo", :phone => "0902445566",
                                 :last_called => DateTime.now ) }
  let!(:c2) { FactoryGirl.create(:contact, :user => user, :name => "Bar", :phone => "0905112233") }

  describe "for non-signed-in users" do
    before { get contacts_path }
    specify { expect(response).to redirect_to(new_user_session_path) }
  end

  describe "for signed-in users" do
    before do
      signin(user.email, user.password)
      visit contacts_path
    end

    it {expect(page).to have_content c1.name}
    it {expect(page).to have_content c1.phone}
    it {expect(page).to have_content c1.last_called }

    it {expect(page).to have_content c2.name}
    it {expect(page).to have_content c2.phone}
    it {expect(page).to have_content c2.email}

  end

end
