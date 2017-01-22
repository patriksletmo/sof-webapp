class ContactsController < ApplicationController

  def press
    @contacts = Contact.where(group: 'press')
  end

  def voloteer
    @contacts = Contact.all
  end

  def expo
    @contacts = Contact.where(group: 'board')
  end

  def contact
    @contacts = Contact.all
  end

end
