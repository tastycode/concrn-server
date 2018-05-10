class CreatePointFences < ActiveRecord::Migration[5.1]
  def change
    create_table :point_fences do |t|
      t.integer :fenceable_id
      t.string :fenceable_type
      t.decimal :lat
      t.decimal :long
      t.integer :radius

      t.timestamps
    end
  end
end
