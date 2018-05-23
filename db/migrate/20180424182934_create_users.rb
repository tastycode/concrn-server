class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :token
      t.datetime :token_issued_at
      t.string :refresh_token
      t.string :password_digest
      t.string :affiliate_id
      t.string :affiliate_role
      t.timestamps
    end
  end
end
