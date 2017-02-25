class WebstoreController < NavigationController

  # Store frontpage with all the wares
  def index

  end


  def charge
    @token = params[:stripeToken]
  end

  def cart

  end

  def checkout
    # get amount from cart
    @amount = 5000
  end

end
