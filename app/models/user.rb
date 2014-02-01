class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :visitors, :dependent => :destroy
  has_many :interests, :dependent => :destroy

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
