class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  validates :first_name, :last_name, presence: true

  def self.alphabetical
    order("last_name asc, first_name asc")
  end

  def role
    if admin || super_admin
      "Admin"
    else
      "Standard"
    end
  end
end
