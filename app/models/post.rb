class Post < ApplicationRecord
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :user, presence: true
end
