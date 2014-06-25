class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer     :project_id
      t.string      :name
      t.datetime    :deadline
      t.boolean     :done
      t.integer     :priority
      t.timestamps
    end
  end
end
