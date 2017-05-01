class OrderItemManagementController < NavigationController

  def index
    @all_items = database.all_order_items
    if @all_items.success?
      puts @all_items
      flash[:success] = 'Alla order items hämtade.'
    else
      flash[:error] = 'Något gick fel.'
    end
  end
end
