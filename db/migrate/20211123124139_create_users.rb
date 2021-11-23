class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.text :line_user_id, null: false, unique: true

      t.timestamps
    end
  end
end
