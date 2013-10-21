ActiveAdmin.register Match do

  index do
    column :championship
    column :local_team
    column :local_score
    column :visitor_team
    column :visitor_score
    column :match_day
    column :starting_time, as: :datetime
    default_actions
  end

  form do |f|
    f.inputs 'Match' do
      f.input :championship
      f.input :local_team
      f.input :visitor_team
      f.input :location
      f.input :match_day
      f.input :starting_time, as: :datetime
    end
    f.inputs 'Résultat' do
      f.input :local_score
      f.input :visitor_score
      f.input :official_url
      # f.input :
      # f.input :
      # f.input :
    end
    f.actions
  end

  controller do
    def permitted_params
      params.permit!
    end
  end
end
