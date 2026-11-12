class PoemKeyword < ApplicationRecord
  belongs_to :poem
  belongs_to :keyword
end
