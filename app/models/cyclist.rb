class Cyclist < ActiveRecord::Base

attr_accessor :email, :username, :password, :password_confirmation
has_secure_password


  def self.authenticate(email, password)
    username = find_by_email(email)
    if username && username.password_hash == BCrypt::Engine.hash_secret(password, username.password_salt)
      username
    else
      nil
    end
  end

  has_many :rides


  validates :username, uniqueness:true
  validates :email, presence:true


  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    Cyclist.all.detect {|x| slug == x.slug}
  end

end
