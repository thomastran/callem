require 'spec_helper'

describe "Contact call page" do
  let(:user) { FactoryGirl.create(:user) }
  let!(:c1) { FactoryGirl.create(:contact, :user => user, :name => "Foo", :phone => "0902445566" ) }

  describe "for non-signed-in users" do
    before { post call_contact_path(c1) }
    specify { expect(response).to redirect_to(new_user_session_path) }
  end

  describe "for signed-in users" do
    before do
      signin(user.email, user.password)
      visit contacts_path

      page.find("a[class='call'][1]").click
    end

    it "should update last called date" do
      c1.reload

      expect(c1.last_called).not_to be_nil
    end
  end

end
