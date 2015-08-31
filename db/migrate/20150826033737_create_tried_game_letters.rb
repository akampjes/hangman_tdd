class CreateTriedGameLetters < ActiveRecord::Migration
  def change
    create_table :tried_game_letters do |t|
      t.integer :game_id
      t.text :letter

      t.timestamps null: false
    end
  end
end
