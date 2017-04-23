class UserInventoryController < NavigationController
  def index
    return if require_login!

    @inventory = database.inventory
  end

  def orders
    return if require_login!

    @orders = database.orders
  end

  def order
    return if require_login!

    @order = database.order(params[:id])
    @total = @order['order_items'].sum { |x| x['cost'] }
  end

  def order_item
    return if require_login!

    @order_item = database.order_item(params[:id])
  end

  def change_owner
    return if require_login!

    response = database.gift_item(params[:id], params[:owner])
    if response.success?
      flash[:success] = "Artikel bortgiven till #{params[:owner]}"
    else
      flash[:error] = 'Kunde inte hitta användaren'
    end

    redirect_to action: :order_item
  end
end
