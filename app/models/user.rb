class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :sex, presence: true
  validates :name, presence: true
  validates :dob, presence: true
  after_create :create_dependents
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#, :confirmable


  include Paperclip::Glue
  # has_attached_file :avatar, :styles => {:original => "200x200#", :thumb => "100x100#", :mini => "25x25#", :tiny => "50x50#" }, :default_url => "/images/normal/missing.png"
  has_attached_file :avatar, :styles => {:original => "200x200#", :thumb => "100x100#", :mini => "25x25#", :tiny => "50x50#" }, :default_url => :default_url_by_gender
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  def default_url_by_gender
    "/images/normal/#{sex}.png"
  end

  has_many :visitors,   :dependent => :destroy
  has_many :interests,  :dependent => :destroy
  has_many :shortlists, :dependent => :destroy
  has_many :images,     :dependent => :destroy

  has_one :profile,   :dependent => :destroy
  has_one :contact,   :dependent => :destroy
  has_one :religion,  :dependent => :destroy
  has_one :kundali,   :dependent => :destroy
  has_one :about,     :dependent => :destroy
  has_one :family,    :dependent => :destroy
  has_one :desire,    :dependent => :destroy
  has_one :education, :dependent => :destroy
  has_one :hobby,     :dependent => :destroy
  has_one :lifestyle, :dependent => :destroy
  has_one :occupation,:dependent => :destroy


  def online?
    updated_at > 10.minutes.ago
  end
  def create_dependents
    build_profile
    build_contact
    build_religion
    build_kundali
    build_about
    build_family
    build_desire
    build_education
    build_hobby
    build_lifestyle
    build_occupation
  end
end
