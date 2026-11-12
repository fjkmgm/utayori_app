class Diary < ApplicationRecord
  belongs_to :user
  belongs_to :poem, optional: true

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true
  validates :written_on, presence: true

  before_save :match_poem

  private

  def match_poem
    text = "#{title} #{body}"
    matched_keywords = Keyword.all.select { |kw| text.include?(kw.name) }

    return if matched_keywords.empty?

    # マッチしたキーワードを一番多く持つ Poem を選出
    poem_scores = Hash.new(0)
    matched_keywords.each do |kw|
      kw.poems.each do |poem|
        poem_scores[poem] += 1
      end
    end

    # 最もマッチ数の多い一首を設定
    best_poem = poem_scores.max_by { |_poem, count| count }&.first
    self.poem = best_poem if best_poem
  end
end
