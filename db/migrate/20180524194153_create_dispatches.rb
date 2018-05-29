class CreateDispatches < ActiveRecord::Migration[5.1]
  def change
    create_table :dispatches do |t|
      t.string :dispatch_type
      t.integer :user_id
      t.integer :responder_id
      t.integer :report_id
      t.string :status

      t.timestamps
    end
  end
end
