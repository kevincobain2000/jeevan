class Badge < ActiveRecord::Base
  nilify_blanks
  belongs_to :user#, touch: true
end
