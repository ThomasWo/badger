class Event < ActiveRecord::Base
  mount_uploader :logo, LogoUploader

  has_many :attendees
  has_many :roles, through: :attendees
  has_many :sponsor_companies
end
