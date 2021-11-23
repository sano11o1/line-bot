class User < ApplicationRecord
  validates :name,  presence: true
  validates :line_user_id, presence: true, uniqueness: true
end
