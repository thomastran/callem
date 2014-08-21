require 'spec_helper'

describe "Contact new page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:c1) { FactoryGirl.create(:contact, :user => user, :name => "Foo", :phone => "0902445566" ) }

  describe "for non-signed-in users" do
    before { get new_contact_path }
    specify { expect(response).to redirect_to(new_user_session_path) }
  end

  describe "for signed-in users" do
    before do
      signin(user.email, user.password)
      visit new_contact_path
    end

    describe "with invalid information" do

      it "should not create a contact" do
        expect { click_button "Create Contact" }.not_to change(Contact, :count)
      end

      describe "error messages" do
        before do
          click_button "Create Contact"
        end
        it { expect(page).to have_content('Please review the problems below') }

      end
    end

    describe "with valid information" do
      before do
        fill_in 'contact_name', :with => "David Kama"
        fill_in 'contact_phone', :with => "0955332311"
      end

      it "should create a contact" do
        expect { click_button 'Create Contact'}.to change(Contact, :count).by(1)
      end
    end

  end

end
