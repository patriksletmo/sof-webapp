class PagesController < ApplicationController
  def index
    @index = "index"
    @info = "info"
    @contacts = "contacts"

  end

  def info
    @index = "index"
    @info = "info"
    @contacts = "contacts"
  end

  def contacts
    @index = "index"
    @info = "info"
    @contacts = "contacts"
  end
end
