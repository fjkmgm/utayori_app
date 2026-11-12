class CreatePoems < ActiveRecord::Migration[8.1]
  def change
    create_table :poems do |t|
      t.integer :number, null: false
      t.string :kami_no_ku, null: false
      t.string :shimo_no_ku, null: false
      t.string :poet, null: false
      t.text :translation, null: false
      t.text :explanation, null: false

      t.timestamps
    end
    add_index :poems, :number, unique: true
  end
end
