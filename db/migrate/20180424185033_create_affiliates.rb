class CreateAffiliates < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliates do |t|
      t.string :name

      t.timestamps
    end
  end
end
