class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :visitors, :dependent => :destroy
  has_many :profiles, :dependent => :destroy
  has_many :interests, :dependent => :destroy
  has_many :contacts, :dependent => :destroy
  has_many :religions, :dependent => :destroy
  has_many :kundalis, :dependent => :destroy
  has_many :abouts, :dependent => :destroy
  has_many :familites, :dependent => :destroy
  has_many :desires, :dependent => :destroy
  has_many :educations, :dependent => :destroy
  has_many :hobbies, :dependent => :destroy
  has_many :lifestyles, :dependent => :destroy
  has_many :occupations, :dependent => :destroy
end
