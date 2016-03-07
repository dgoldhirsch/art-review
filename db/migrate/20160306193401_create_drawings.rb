class CreateDrawings < ActiveRecord::Migration
  def change
    create_table :drawings do |t|
      t.integer :artist_id

      t.timestamps
    end
  end
end
