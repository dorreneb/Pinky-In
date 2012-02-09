class CreateWinerequests < ActiveRecord::Migration
  def change
    create_table :winerequests do |t|
      t.float :budget
      t.integer :numPeople

      t.timestamps
    end
  end
end
