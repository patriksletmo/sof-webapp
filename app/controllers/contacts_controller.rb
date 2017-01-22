class ContactsController < ApplicationController

  def press
    @contacts = Contact.where(group: 'low')
  end

  def voloteer
    @contacts = Contact.all
  end

  def expo
    @contacts = Contact.all
  end

  def contact
    @contacts = Contact.where(group: 'high')
  end

end
