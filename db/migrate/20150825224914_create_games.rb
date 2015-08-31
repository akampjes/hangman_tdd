class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :lives
      t.text :word

      t.timestamps null: false
    end
  end
end
