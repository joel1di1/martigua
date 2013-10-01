ActiveAdmin.register User do

  index do
    column :email
    column :first_name
    column :last_name
    column :nickname
    column :active
    column :phone
    column :cotisation
    column :certificat_medical
    column :current_sign_in_at
    default_actions
  end

  form do |f|
    f.inputs "Utilisateur" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :nickname
      f.input :phone
      f.input :active
      f.input :cotisation
      f.input :certificat_medical
    end
    f.actions
  end


  controller do
    def permitted_params
      params.permit!
    end
  end
end
