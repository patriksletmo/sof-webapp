class ContactsController < ApplicationController

  def press
    @contacts = Contact.where(group: 'huvudansvarig')
  end

  def voloteer
    @contacts = Contact.all
  end

  def expo
    @contacts = Contact.where(group: 'styrelse')
  end

  def contact
    @contacts = Contact.all
  end

end
