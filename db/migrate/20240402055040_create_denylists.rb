class CreateDenylists < ActiveRecord::Migration[6.0] # or [7.0] depending on your Rails version
  def change
    create_table :denylists do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false

      t.timestamps
    end
    add_index :denylists, :jti, unique: true
  end
end
