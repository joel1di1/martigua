class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.boolean :cotisation
      t.boolean :certificat_medical
      t.boolean :active

      t.timestamps
    end
  end
end
