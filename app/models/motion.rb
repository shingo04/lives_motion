class Motion < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :run
    validates :abs
    validates :squat
    validates :push_ups
    validates :spine
  end
end
