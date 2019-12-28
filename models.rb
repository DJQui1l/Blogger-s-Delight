class User < ActiveRecord::Base
  validates :firstname, :lastname, :email,
  :birthday, :password, presence: true
  validates :email, uniqueness: true
end

class Posts < ActiveRecord::Base

end
