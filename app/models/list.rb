class List < ApplicationRecord
  belongs_to :user
  has_many :book_lists, dependent: :destroy
  has_many :books, through: :book_lists
  has_one_attached :picture

  enum :status, { default: 0, personal: 1 }

  validates :status, presence: true
  validates :name, uniqueness: { scope: [ :user_id, :status ], message: "should be unique per user for default lists" }, if: -> { default? }
  validates :name, presence: true

  # defining scope for easier use later
  scope :default_lists, -> { where(status: :default) }
  scope :personal_lists, -> { where(status: :personal) }
end
