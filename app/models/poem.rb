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

  def self.search(query)
    return all if query.blank?

    term = query.strip
    normalized_number = term.tr("０-９", "0-9")
    sanitized = "%#{sanitize_sql_like(term)}%"

    scope = left_joins(:keywords).distinct

    if normalized_number.match?(/\A\d+\z/)
      scope.where(
        "poems.number = :num OR poems.poet LIKE :q OR keywords.name LIKE :q",
        num: normalized_number.to_i,
        q: sanitized
      )
    else
      scope.where(
        "poems.poet LIKE :q OR keywords.name LIKE :q OR poems.kami_no_ku LIKE :q OR poems.shimo_no_ku LIKE :q",
        q: sanitized
      )
    end
  end
end
