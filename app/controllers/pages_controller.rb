class PagesController < ApplicationController
  def index
    category = params[:category] || "index"
    page = params[:page] || ""

    @page = Page.find_by(category: category, page: page)

    if @page.nil?
      render nothing: false, status: 404
    end
  end

end
