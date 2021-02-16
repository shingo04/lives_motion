class Tweet < ApplicationRecord
  validates :content, presence: true, unless: :was_attached?

  belongs_to :user
  has_one_attached :image
  has_many :comments

  def was_attached?
    self.image.attached?
  end
end
