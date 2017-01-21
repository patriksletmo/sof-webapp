class PagesController < ApplicationController
  def index
    category = params[:category]
    page = params[:page]

    @page = Page.find_by(category: category, page: page)
    if @page.nil?
      render nothing: true, status: 404
    end
  end




  def info

  end

end
