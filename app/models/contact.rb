class Contact < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('name ASC') }

  validates :user_id, :presence => true
  validates :name, :presence => true,  :length => { :maximum => 30}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :allow_blank => true
  validates :email, :length => { :maximum => 50}

  validates_format_of :phone, :with => /\A[-+]?[0-9]+\z/, :allow_blank => true
  validates :phone, :length => { :maximum => 15}

  validates :last_called, :length => { :maximum => 15}

end
