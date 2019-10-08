class Author < ApplicationRecord
    has_many :posts, dependent: :destroy
end
