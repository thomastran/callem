require 'spec_helper'

describe "Contact edit page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:c1) { FactoryGirl.create(:contact, :user => user, :name => "Foo", :phone => "0902445566" ) }

  describe "for non-signed-in users" do
    before { get edit_contact_path(c1) }
    specify { expect(response).to redirect_to(new_user_session_path) }
  end

  describe "for signed-in users" do
    before do
      signin(user.email, user.password)
    end

    it "should return 404 when contact not exists" do
      expect {
        visit edit_contact_path(9999)
      }.to raise_error(ActionController::RoutingError)
    end

    describe "when contact not belong to user" do
      it "should return 403 error" do
        user1 = FactoryGirl.create(:user)
        contact1 = FactoryGirl.create(:contact, :user => user1, :name => "Bar", :phone => "0902445561" )

        visit edit_contact_path(contact1)

        expect(page.status_code).to eql(403)

      end
    end

    describe "with invalid information" do
      before do
        visit edit_contact_path(c1)
        fill_in 'contact_phone', :with => "abc"
      end

      it "should not create a contact" do
        expect { click_button "Update Contact" }.not_to change(Contact, :count)
      end

      it "should show error messages" do
        click_button "Update Contact"
        expect(page).to have_content('Please review the problems below')
      end

    end

    describe "with valid information" do
      before do
        visit edit_contact_path(c1)

        fill_in 'contact_name', :with => "Contact name 1"
        fill_in 'contact_phone', :with => "0955332311"
        click_button "Update Contact"

      end

      it "should update the contact" do
        c1.reload
        expect(c1.name).to eql "Contact name 1"
        expect(c1.phone).to eql "0955332311"
      end
    end
  end

end
