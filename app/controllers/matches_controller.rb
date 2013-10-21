class MatchesController < InheritedResources::Base
  
  protected
    def begin_of_association_chain
      params[:team_id] ? Team.find(params[:team_id]) : nil
    end

    def collection
      @matches ||= end_of_association_chain.includes(:match_day).order('LEAST(starting_time, match_days.start_date)')
    end

end
