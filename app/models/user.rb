class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, length: { maximum: 10, message: "10文字以内" }
    with_options numericality: { other_than: 0 } do
      validates :age
      validates :height
      validates :weight
    end
  end
  validates :gender_id, numericality: { other_than: 0 } 

  mount_uploader :image, ImageUploader

  has_many :tweets, dependent: :destroy
  has_many :motions, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :gender
end
