class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :task_id
      t.string :body
      t.string :file_name

      t.timestamps
    end
  end
end
