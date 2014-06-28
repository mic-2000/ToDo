class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer     :project_id
      t.string      :name
      t.date        :deadline
      t.boolean     :done, default: false
      t.integer     :priority
      t.timestamps
    end
  end
end
