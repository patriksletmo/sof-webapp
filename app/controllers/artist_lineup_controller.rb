class ArtistLineupController < NavigationController

  def index
    @artist_lineups = database.get_orchestras_from_lineups
    unless @artist_lineups.success?
      flash.now[:error] = 'Kunde inte hämta artist'
      @artist_lineups={}
    end
    @artist_lineups = @artist_lineups.sort_by {|t| t["name"]}
  end
end
