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

  has_many :tweets
end