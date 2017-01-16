class PagesController < ApplicationController
  def index
    @sidebar_index = "index"
    @sidebar_info = "info"
    @sidebar_contacts = "contacts"

  end

  def info
    @sidebar_index = "index"
    @sidebar_info = "info"
    @sidebar_contacts = "contacts"
  end

  def contacts
    @sidebar_index = "index"
    @sidebar_info = "info"
    @sidebar_contacts = "contacts"
    @contacts = Contact.all

  end
end
