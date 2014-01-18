class Profile < ActiveRecord::Base
  belongs_to :users
  has_many :visitors
  has_many :interests
end
