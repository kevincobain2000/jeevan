class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :sex, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  include Paperclip::Glue
  has_attached_file :avatar, :styles => { :medium => "750x750#", :thumb => "100x100#" }, :default_url => "/images/normal/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :visitors, :dependent => :destroy
  has_many :interests, :dependent => :destroy
  has_many :images, :dependent => :destroy

  has_one :profile, :dependent => :destroy
  has_one :contact, :dependent => :destroy
  has_one :religion, :dependent => :destroy
  has_one :kundali, :dependent => :destroy
  has_one :about, :dependent => :destroy
  has_one :family, :dependent => :destroy
  has_one :desire, :dependent => :destroy
  has_one :education, :dependent => :destroy
  has_one :hobby, :dependent => :destroy
  has_one :lifestyle, :dependent => :destroy
  has_one :occupation, :dependent => :destroy
end
