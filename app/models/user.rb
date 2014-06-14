class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :sex, presence: true
  validates :name, presence: true
  validates :devotion, presence: true
  validates :dob, presence: true
  validates_date :dob, :before => lambda { 18.years.ago }, :before_message => "Must be at least 18 years old"
  validates :username, presence: true, :length => { :minimum => 5, :maximum => 50 }, uniqueness: true
  username_regexp = /\A[^@]+[^@][^@]+\z/
  validates_format_of :username, :with => username_regexp, :if => :username_required?
  # validates_uniqueness_of    :email,     :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  # validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  after_create :create_dependents
  devise :database_authenticatable, :registerable, :omniauthable,
          :recoverable, :rememberable, :trackable, :validatable#, :confirmable

  include Paperclip::Glue
  has_attached_file :avatar, :styles => {:thumb => "200x200#", :tiny => "50x50#"}, :convert_options => {:thumb => "-quality 100", :tiny => "-quality 100" },:default_url => :default_url_by_gender
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  def default_url_by_gender
    random = 0
    "/images/normal/#{sex}-#{random}.png"
  end

  has_many :visitors,       :dependent => :destroy
  has_many :interests,      :dependent => :destroy
  has_many :shortlists,     :dependent => :destroy
  has_many :images,         :dependent => :destroy
  has_many :messages,       :dependent => :destroy

  has_one :badge,     :dependent => :destroy
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


  delegate :marital_status,:home, to: :profile
  delegate :mother_tongue, :caste, :native_place, to: :religion
  delegate :birth_country,:birth_city,:sun_sign, :manglik, to: :kundali
  delegate :me, to: :about

  searchable do
    #user
    integer :images_count
    text :dob
    string :dob
    string :sex
    text :devotion
    #profile
    string :home
    text :marital_status
    text :caste
    string :manglik
    #religion, kundali, about me
    text :mother_tongue, :native_place
    text :birth_country,:birth_city,:sun_sign
    text :me
  end

  # after_touch :index # do something

  def online?
    updated_at > 10.minutes.ago
  end
  def create_dependents
    dateofbirth = dob.to_s.gsub("/","-")
    _age = Date.today.year - dateofbirth.to_date.year

    build_profile
    build_badge
    build_contact
    build_religion
    build_kundali
    build_about
    build_family
    build_desire(:desired_religion => devotion)
    build_education
    build_hobby
    build_lifestyle
    build_occupation
  end
  def email_required?
    false
  end

  def email_changed?
    false
  end
  def username_required?
    provider.blank?
  end
  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if !user.nil?
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            # email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                            sex: auth.extra.raw_info.gender ? auth.extra.raw_info.gender.to_s.capitalize : "Unknown",
                            username: "#{auth.info.email}_facebook",
                            dob: auth.extra.raw_info.birthday ? auth.extra.raw_info.birthday : "01/01/1985",
                            devotion: "Hindu",
                            name: auth.info.name,
                            avatar: URI.parse(process_uri(auth.info.image))
                          )
      end
    end
  end
  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if !user.nil?
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            # email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                            sex: auth.extra.raw_info.gender ? auth.extra.raw_info.gender.to_s.capitalize : "Unknown",
                            username: "#{auth.info.nickname}_twitter.com",
                            dob: auth.extra.raw_info.birthday ? auth.extra.raw_info.birthday : "01/01/1900",
                            devotion: "Hindu",
                            name: auth.info.name,
                            avatar: URI.parse(process_uri(auth.info.image))
                          )
      end
    end
  end
  def self.find_for_linkedin_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if !user.nil?
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            # email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                            sex: auth.extra.raw_info.gender ? auth.extra.raw_info.gender.to_s.capitalize : "Unknown",
                            username: "#{auth.info.email}_linkedin",
                            dob: auth.extra.raw_info.birthday ? auth.extra.raw_info.birthday : "01/01/1900",
                            devotion: "Hindu",
                            name: auth.info.name,
                            avatar: URI.parse(process_uri(auth.info.image))
                          )
      end
    end
  end

  def self.find_for_google_oauth2(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if !user.nil?
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            # email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                            sex: auth.extra.raw_info.gender ? auth.extra.raw_info.gender.to_s.capitalize : "Unknown",
                            username: "#{auth.info.email}_google_oauth2",
                            dob: auth.extra.raw_info.birthday ? auth.extra.raw_info.birthday : "01/01/1900",
                            devotion: "Hindu",
                            name: auth.info.name,
                            avatar: URI.parse(process_uri(auth.info.image))
                          )
      end
    end
  end

  def self.process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end

end
