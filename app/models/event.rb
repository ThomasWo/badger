class Event < ActiveRecord::Base
  mount_uploader :logo, LogoUploader

  has_many :attendees
end
