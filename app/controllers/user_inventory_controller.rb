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
    if @order.success?
      @total = @order['order_items'].sum { |x| x['cost'] } - @order['rebate'] - @order['funkis_rebate']
    else
      flash[:error] = 'Kunde inte hitta order'
      redirect_to action: :orders
    end
  end

  def order_item
    return if require_login!

    @order_item = database.order_item(params[:id])
    unless @order_item.success?
      flash[:error] = 'Kunde inte hitta artikel'
      redirect_to action: :index
    end
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
