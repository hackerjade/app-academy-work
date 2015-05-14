class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    create_table :albums do |t|
      t.string :name
      t.integer :band_id
      t.string :album_type


      t.timestamps null: false
    end

    create_table :tracks do |t|
      t.string :name
      t.integer :album_id
      t.string :track_type
      t.text :lyrics

      t.timestamps null: false
    end
  end
end
