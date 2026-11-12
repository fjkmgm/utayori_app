class AddPoemRefToDiaries < ActiveRecord::Migration[8.1]
  def change
    add_reference :diaries, :poem, foreign_key: true
  end
end
