class ContactsController < ApplicationController

  def press
    @contacts = Contact.all
    @header_title = "Press"
  end

  def voloteer
    @contacts = Contact.all
    @header_title = "Volonteer"

  end

  def expo
    @contacts = Contact.all

    @header_title = "Expo"
  end

  def contact
    @contacts = Contact.all

    @header_title = "Board"
  end

end
