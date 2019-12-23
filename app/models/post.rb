class Post < ActiveRecord::Base
  belongs_to :cyclist
  has_many :rides

   validates :title, :description, presence: true
end
