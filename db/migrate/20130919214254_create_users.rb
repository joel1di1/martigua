class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :cotisation, null: false, default: false
      t.boolean :certificat_medical, null: false, default: false
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
