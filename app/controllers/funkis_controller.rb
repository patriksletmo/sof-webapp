class FunkisController < NavigationController
  def index

  end

  def categories
    @categories = database.funkis_categories
  end

  def application

  end

  def new
    
  end
end
