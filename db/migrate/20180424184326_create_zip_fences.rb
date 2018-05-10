class CreateZipFences < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_fences do |t|
      t.integer :fenceable_id
      t.string :fenceable_type
      t.string :zip

      t.timestamps
    end
  end
end
