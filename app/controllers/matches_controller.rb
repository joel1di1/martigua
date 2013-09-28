class MatchesController < InheritedResources::Base
  
  protected
    def begin_of_association_chain
      params[:team_id] ? Team.find(params[:team_id]) : nil
    end

end
