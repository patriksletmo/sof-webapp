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
    @token = params[:stripeToken]
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
    # get amount from cart
    @amount = 5000
  end

end
