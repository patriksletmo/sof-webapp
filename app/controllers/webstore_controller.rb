class WebstoreController < NavigationController

  # Store frontpage with all the wares
  def index

  end

  def test
    new_item = {
        object_type: 'ticket',
        object_name: 'Biljett'
    }

    database.add_item_to_cart new_item
    redirect_to action: :index
  end

  def charge
    return if require_login!

    @token = params[:stripeToken]

    response = database.pay_for_order()
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
end
