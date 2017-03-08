class Sport < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :preferences
  has_many :users, through: :preferences
  validates :name, presence: true, uniqueness: true
end
