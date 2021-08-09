class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id, foreign_key: true
      t.integer :book_id, foreign_key: true

      t.timestamps
      t.index [:user_id, :book_id], unique: true #追加
    end
  end
end
