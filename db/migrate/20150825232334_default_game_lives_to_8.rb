class DefaultGameLivesTo8 < ActiveRecord::Migration
  def change
    change_column_default :games, :lives, 8
  end
end
