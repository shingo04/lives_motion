class Tweet < ApplicationRecord
  validates :content, presence: true, unless: :was_attached?

  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy

  def was_attached?
    self.image.attached?
  end

  def self.search(search)
    if search != ""
      Tweet.where('content LIKE(?)', "%#{search}%")
    else
      Tweet.includes(:user).order(id: "DESC").first(10)
    end
  end
end
