class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.timestamps
      t.integer :backlog_item_id
      t.string :name
    end
  end
end
