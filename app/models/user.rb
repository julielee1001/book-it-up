class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :first_name, :last_name, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :reviews
  has_many :lists

  after_create :create_default_lists

  private
  def create_default_lists
    lists.create(name: "Favorites", status: :default)
    lists.create(name: "Wishlist", status: :default)
  end
end
