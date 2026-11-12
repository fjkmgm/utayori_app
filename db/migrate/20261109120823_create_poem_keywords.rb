class CreatePoemKeywords < ActiveRecord::Migration[8.1]
  def change
    create_table :poem_keywords do |t|
      t.references :poem, null: false, foreign_key: true
      t.references :keyword, null: false, foreign_key: true

      t.timestamps
    end

    add_index :poem_keywords, [:poem_id, :keyword_id], unique: true
  end
end