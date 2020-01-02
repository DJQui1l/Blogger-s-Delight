class User < ActiveRecord::Base
  attr_accessor :email
  validates :first_name, :last_name, :email, :birthday, :password, presence: true

  validates :email, uniqueness: true
end

class Post < ActiveRecord::Base
  belongs_to :users
end
