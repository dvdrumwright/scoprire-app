class Post < ActiveRecord::Base
  belongs_to :cyclist
  has_many :rides, through: :cyclist

   validates :title, :description, presence: true
end
