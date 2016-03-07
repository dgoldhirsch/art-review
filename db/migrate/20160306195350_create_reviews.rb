class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :artist_id
      t.integer :drawing_id
    end
  end
end
