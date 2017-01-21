class PagesController < ApplicationController
  def index
    category = params[:category]
    page = params[:page]


    if category == nil and page == nil
      @page = Page.find_by(category: "index", page: "")
    else
      @page = Page.find_by(category: category, page: page)
    end

    if @page.nil?
      render nothing: false, status: 404
    end
  end

end
