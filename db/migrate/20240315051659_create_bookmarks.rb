class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.integer :quiz_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
