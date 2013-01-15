class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.string :name
      t.string :size
      t.integer :qty
      t.string :keypair
      t.string :security_group
      t.string :password

      t.timestamps
    end
  end
end
