class UserLogin < ActiveRecord::Base
  belongs_to :admin_user

  validates :user_id, presence: true
  validates :ip, presence: true
end
