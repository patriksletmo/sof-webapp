class PagesController < ApplicationController
  def index
    @header_title = "Studentorkesterfestivalen 2017"
    @header = "SOF17"
  end

  def info
    @header_title = "Info"
    @header = "Information"
  end

  def contacts
    @header_title = "Contacts"
    @header = "Styrelsen"
    @contacts = Contact.all


  end
end
