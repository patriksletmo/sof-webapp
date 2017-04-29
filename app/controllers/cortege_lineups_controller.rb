class CortegeLineupsController < NavigationController

  def index
    cortege_lineups = database.all_corteges_lineup
    unless cortege_lineups.success?
      flash[:error] = 'Kunde inte hämta kårtege'
      cortege_lineups={}
    end
    puts(cortege_lineups)
    @cortege_lineups = cortege_lineups.sort_by {|t| t.order}

  end
end
