class CreateFavorites < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.string :pet_id
      t.text :breeds
      t.string :name
      t.string :size
      t.string :age
      t.string :sex
      t.string :location
      t.string :status
      t.string :pet_type
      t.string :photo
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
