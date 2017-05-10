class CortegeLineupsController < NavigationController

  def index
    @cortege_lineups = database.get_corteges_from_lineups
    unless @cortege_lineups.success?
      flash.now[:error] = 'Kunde inte hämta lineup'
      @cortege_lineups={}
    end
    @cortege_lineups = @cortege_lineups.sort_by {|t| t["order"]}
  end
end
