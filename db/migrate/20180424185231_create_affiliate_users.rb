class CreateAffiliateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :affiliate_users do |t|
      t.integer :affiliate_id
      t.integer :user_id
      t.string :role

      t.timestamps
    end
  end
end
