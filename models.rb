class User < ActiveRecord::Base
  # attr_accessor :email
  validates :first_name, :last_name, :email, :birthday, :password, presence: true

  validates :email, uniqueness: true

  # has_many: :posts, dependent: :destroy
end

class Post < ActiveRecord::Base
  belongs_to :user

  validates :content, length: {minimum: 1}

end
