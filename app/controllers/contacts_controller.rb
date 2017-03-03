class ContactsController < NavigationController

  def press
    @group = ContactGroup.where(group: 'press').take
    @contacts = Contact.where(group: 'press')
    render :index
  end

  def funkis
    @group = ContactGroup.where(group: 'funkis').take
    @contacts = Contact.where(group: 'funkis')
    render :index
  end

  def orchestra
    @group = ContactGroup.where(group: 'orchestra').take
    @contacts = Contact.where(group: 'orchestra')
    render :index
  end

  def cortege
    @group = ContactGroup.where(group: 'cortege').take
    @contacts = Contact.where(group: 'cortege')
    render :index
  end

  def tickets
    @group = ContactGroup.where(group: 'tickets').take
    @contacts = Contact.where(group: 'tickets')
    render :index
  end

  def it
    @group = ContactGroup.where(group: 'it').take
    @contacts = Contact.where(group: 'it')
    render :index
  end
end
