class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :sex, presence: true
  validates :name, presence: true
  validates :devotion, presence: true
  validates :dob, presence: true
  after_create :create_dependents
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  delegate :posted_by, to: :profile
  delegate :mother_tongue,:caste,:native_place, to: :religion
  delegate :birth_country,:birth_city,:sun_sign, to: :kundali
  delegate :complexion,:blood, to: :lifestyle
  delegate :me, to: :about
  delegate :status,:size, to: :family
  delegate :highest_degree, to: :education
  delegate :interest,:music, :read,:dress, :tv,:movie, :sport,:vacation, to: :hobby

  include Paperclip::Glue
  has_attached_file :avatar, :styles => {:thumb => "200x200#", :tiny => "50x50#"}, :convert_options => {:thumb => "-quality 100", :tiny => "-quality 100" },:default_url => :default_url_by_gender
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  def default_url_by_gender
    # random = rand(0)
    random = 0
    "/images/normal/#{sex}-#{random}.png"
  end

  has_many :visitors,       :dependent => :destroy
  has_many :interests,      :dependent => :destroy
  has_many :notifications,  :dependent => :destroy
  has_many :shortlists,     :dependent => :destroy
  has_many :images,         :dependent => :destroy

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

  searchable do
    integer :images_count
    text :posted_by
    text :mother_tongue, :caste, :native_place
    text :birth_country,:birth_city,:sun_sign
    text :complexion,:blood
    text :me
    text :status,:size
    text :highest_degree
    text :interest, :music, :read,:dress, :tv,:movie, :sport,:vacation
    string :sex
  end

  # after_touch :index # do something

  def online?
    updated_at > 10.minutes.ago
  end
  def create_dependents
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
end
