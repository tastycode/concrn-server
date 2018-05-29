class ChangeUserAffiliateIdToString < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :affiliate_id
    add_column :users, :affiliate_id, :integer
  end
end
