class Image < ActiveRecord::Base
  belongs_to :user
  include Paperclip::Glue
  has_attached_file :avatar, :styles => {:thumb => "100x100#", :tiny=> "35x35#" },:convert_options => {:thumb => "-quality 100" },:default_url => "/images/normal/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
