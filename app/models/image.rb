class Image < ActiveRecord::Base
  belongs_to :user
  include Paperclip::Glue
  has_attached_file :avatar, :styles => { :medium => "550x550#", :thumb => "100x100#" }, :default_url => "/images/normal/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
