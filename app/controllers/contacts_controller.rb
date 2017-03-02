class ContactsController < NavigationController

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
    @groups = ContactGroup.all
  end
end
