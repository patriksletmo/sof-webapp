class WebstoreController < NavigationController

  # Store frontpage with all the wares
  def index
    @products = database.enabled_products
  end

  def test
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
    @cart = database.get_cart
  end

  def remove_item_from_cart
    database.remove_item_from_cart params[:id]
    redirect_to action: :cart
  end

  def clear_cart
    database.clear_cart
    redirect_to action: :cart
  end

  def checkout
    return if require_login!
      # get amount from cart
    @amount = 5000
    @response = database.create_order()
    if response.success?
    else
      #show error, redirect to webshop
    end
  end

  def charge
    return if require_login!

    @token = params[:stripeToken]

    response = database.pay_for_order()
  end

  private

  def data_json
    options = params[:options]
    unless options.blank?
      JSON.dump options.to_unsafe_h
    end
  end
end
