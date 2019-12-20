class Cyclist < ActiveRecord::Base
  has_many :rides
  has_many :post, through: :rides

  validates :name, :email, presence: true

  has_secure_password

end
