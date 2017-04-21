class WebstoreController < NavigationController

  # Store frontpage with all the wares
  def index
    @products = database.enabled_products
  end

  def add_item_to_cart
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
    fetch_cart!
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

    fetch_cart!

    if request.post?
      # get amount from cart
      @response = database.create_order()
      if response.success?
      else
        #show error, redirect to webshop
      end
    end
  end

  def charge
    return if require_login!

    stripe_token = params[:stripe_token]
    response = database.charge(stripe_token)
    if response.success?
      flash[:success] = 'Betalningen lyckades'
      redirect_to '/'
    else
      flash[:error] = 'Betalningen misslyckades'
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
    @total = @cart['cart_items'].sum { |x| x['product']['base_product']['cost'] }
  end
end
