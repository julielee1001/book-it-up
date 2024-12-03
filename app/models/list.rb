class List < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 10 }
  enum type: { default: 0 personal: 1 }
  
end
