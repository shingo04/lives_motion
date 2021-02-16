class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    with_options numericality: { other_than: 0 } do
      validates :age
      validates :height
      validates :weight
      validates :bmr
    end
  end

  mount_uploader :image, ImageUploader

  has_many :tweets
  has_many :motions
  has_many :comments
end
