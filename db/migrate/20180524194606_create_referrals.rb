class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.integer :user_id
      t.integer :report_id
      t.integer :affiliate_id
      t.string :notes

      t.timestamps
    end
  end
end
