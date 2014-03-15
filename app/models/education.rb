class Education < ActiveRecord::Base
  nilify_blanks
  belongs_to :user
end
