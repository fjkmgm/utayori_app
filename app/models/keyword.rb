class Keyword < ApplicationRecord
  has_many :poem_keywords, dependent: :destroy
  has_many :poems, through: :poem_keywords

  validates :name, presence: true, uniqueness: true
end