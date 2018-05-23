class ChangeUserRolesToRole < ActiveRecord::Migration[5.1]
  def up
    role_map = User.all.reduce({}) do |map, user|
      warn "Truncating user.roles for #{user.email}" if user.roles.count > 1
      map[user.id] = user.roles.first
      map
    end
    remove_column :users, :roles
    add_column :users, :role, :string
    role_map.each do |user_id, role|
      User.find(user_id).update_attributes(role: role)
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
