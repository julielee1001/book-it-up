class BookList < ApplicationRecord
  belongs_to :book, dependent: :destroy
  belongs_to :list, dependent: :destroy
end
