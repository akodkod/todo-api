class Todo < ApplicationRecord
  # Associations
  belongs_to :user

  # Validation
  validates :user, presence: true
  validates :text, presence: true
end
