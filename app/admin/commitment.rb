ActiveAdmin.register Commitment do

  index do
    column :id
    column :team, sortable: 'teams.name'
    column :championship, sortable: 'championships.name'
    default_actions
  end

  controller do
    def permitted_params
      params.permit!
    end
    def scoped_collection
      resource_class.includes(:team).includes(:championship) # prevents N+1 queries to your database
    end
  end
end
