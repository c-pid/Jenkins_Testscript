class CreateTestcases < ActiveRecord::Migration
  def change
    create_table :testcases do |t|
      t.string :name
      t.datetime :time_last_run
      t.text :description
      t.string :state
      t.string :path
      t.integer :test_type

      t.timestamps null: false
    end
  end
end
