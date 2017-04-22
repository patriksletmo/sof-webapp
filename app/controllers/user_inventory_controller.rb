class UserInventoryController < NavigationController
  def orders
    @orders = database.orders
  end

  def order
    @order = database.order(params[:id])
    @total = @order['order_items'].sum { |x| x['product']['base_product']['cost'] }
  end

  def order_item
    @order_item = database.order_item(params[:id])
  end

  def change_owner
    response = database.gift_item(params[:id], params[:owner])
    if response.success?
      flash[:success] = "Artikel bortgiven till #{params[:owner]}"
    else
      flash[:error] = 'Kunde inte hitta användaren'
    end

    redirect_to action: :order_item
  end
end
