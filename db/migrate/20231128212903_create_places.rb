class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :name
      t.integer :google_place_id

      t.timestamps
    end
  end
end
