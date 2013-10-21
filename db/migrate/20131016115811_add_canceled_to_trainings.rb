class AddCanceledToTrainings < ActiveRecord::Migration
  def change
    add_column :trainings, :canceled, :boolean, null: false, default: false
    add_column :trainings, :cancelation_reason, :text
  end
end
