class Image < ActiveRecord::Base
  belongs_to :user
  include Paperclip::Glue
  has_attached_file :avatar, :styles => { :medium => "750x750#", :thumb => "150x150#" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
