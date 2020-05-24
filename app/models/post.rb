class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  validates :caption,  length: { maximum: 10 }, presence: true
  accepts_nested_attributes_for :photos
end
