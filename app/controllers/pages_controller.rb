class PagesController < ApplicationController
  def index

  end

  def info
  end

  def contacts
    @contacts = Contact.all


  end
end
