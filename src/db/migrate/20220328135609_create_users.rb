class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false, default: 'noname'
      t.integer :role, null: false, default: 0
      t.integer :lifespan, null: false, default: 30
      t.date :death_anniversary, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
