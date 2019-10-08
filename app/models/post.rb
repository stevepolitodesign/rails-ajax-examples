class Post < ApplicationRecord
  belongs_to :author
  has_many :comments, dependent: :destroy
end
