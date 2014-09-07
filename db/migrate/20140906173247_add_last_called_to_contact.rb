class AddLastCalledToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :last_called, :datetime
  end

end
