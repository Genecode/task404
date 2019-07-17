class User < ApplicationRecord
  validates :name, :address, :age, presence: true
end
