class Poem < ApplicationRecord
  has_many :poem_keywords, dependent: :destroy
  has_many :keywords, through: :poem_keywords
  has_many :diaries, dependent: :nullify

  validates :number, presence: true, uniqueness: true
  validates :kami_no_ku, presence: true
  validates :shimo_no_ku, presence: true
  validates :poet, presence: true
  validates :translation, presence: true
  validates :explanation, presence: true
end
