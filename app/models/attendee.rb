class Attendee < ActiveRecord::Base
  belongs_to :event
  belongs_to :role

  def self.alphabetical
    order("last_name asc, first_name asc")
  end

  def self.pending
    where(exported: false)
  end

  def name
    [first_name, last_name].join(" ")
  end
end
