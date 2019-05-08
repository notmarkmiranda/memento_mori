class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :phone_number
      t.string :confirmation_number
      t.string :confirmation_expiration
      t.boolean :confirmed, default: false

      t.timestamps null: false
    end
  end
end
