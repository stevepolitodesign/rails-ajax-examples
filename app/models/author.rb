class Author < ApplicationRecord
    has_many :posts, dependent: :destroy

    validates :first_name, presence: true
    validates :last_name, presence: true

    def formatted_name
        "#{self.first_name} #{self.last_name}"
    end
end
