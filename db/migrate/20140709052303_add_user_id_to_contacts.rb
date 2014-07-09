class AddUserIdToContacts < ActiveRecord::Migration
  def change
    add_reference :contacts, :user, :index => true

  end
end
