class Contact < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('name ASC') }

  validates :user_id, :presence => true
  validates :name, :presence => true,  :length => { :maximum => 30}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  phony_normalize :phone, :default_country_code => 'US'
  validates :phone, :phony_plausible => true

end
