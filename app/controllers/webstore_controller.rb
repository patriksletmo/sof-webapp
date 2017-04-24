class WebstoreController < NavigationController
  include UserManagementHelper

  # Store frontpage with all the wares
  def index
    @products = database.products(all: false)
  end

  def add_item_to_cart
    return if require_login!

    new_item = {
        product_id: params[:product_id],
        data: data_json
    }

    response = database.add_item_to_cart new_item
    unless response.success?
      flash[:error] = 'Kunde inte lägga vara i kundvagn'
    end

    redirect_to action: :index
  end

  def cart
    return if require_login!

    fetch_cart!
  end

  def remove_item_from_cart
    return if require_login!

    database.remove_item_from_cart params[:id]
    redirect_to action: :cart
  end

  def clear_cart
    return if require_login!

    database.clear_cart
    redirect_to action: :cart
  end

  def checkout
    return if require_login!

    fetch_cart!

    @is_funkis = is_given? current_user['usergroup'], 4
  end

  def charge
    return if require_login!

    stripe_token = params[:stripe_token]
    response = database.charge(stripe_token)
    if response.success?
      flash[:success] = 'Köp genomfört!'
      redirect_to controller: :user_inventory, action: :order, id: response['id']
    else
      if response.code == 406
        flash[:error] = 'En eller flera av dina produkter överstiger det maximala antalet du kan köpa, eller så finns det inte nog med biljetter kvar'
      else
        flash[:error] = 'Betalningen misslyckades'
      end
      redirect_to action: :checkout
    end
  end

  private

  def data_json
    options = params[:options]
    unless options.blank?
      JSON.dump options.to_unsafe_h
    end
  end

  def fetch_cart!
    @cart = database.get_cart
    @total = @cart['cart_items'].sum { |x| x['product']['actual_cost'] } - @cart['rebate'] - @cart['funkis_rebate']
  end
end
