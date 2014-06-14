class Profile < ActiveRecord::Base
  nilify_blanks
  belongs_to :user
end
