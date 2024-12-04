class List < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :books
  
  enum status: { default: 0, personal: 1 }
  
  validates :status, presence: true
  validates :name, uniqueness: { scope: [:user_id, :status], message: "should be unique per user for default lists" }, if: -> { default? }

  # defining scope for easier use later
  scope :default_lists, -> { where(status: :default) }
  scope :personal_lists, -> { where(status: :personal) }
end