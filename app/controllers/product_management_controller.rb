class ProductManagementController < NavigationController
  def index
    return if require_login!

    @products = database.products
    unless @products.success?
      redirect_to '/'
    end
  end

  def new
    return if require_login!
    @product = {}
  end

  def create
    return if require_login!

    response = database.create_product(item_params)
    if response.success?
      flash[:success] = 'Produkt skapad'
      redirect_to action: :show, id: response['id']
    else
      flash[:error] = 'Kunde inte skapa produkt'
      redirect_to action: :new
    end
  end


  def show
    return if require_login!

    @product = database.get_product(params[:id])
    unless @product.success?
      redirect_to '/'
    end
  end

  def update
    return if require_login!

    response = database.update_product(params[:id], item_params)
    if response.success?
      flash[:success] = 'Produkt uppdaterad'
    else
      flash[:error] = 'Kunde inte uppdatera produkt'
    end

    redirect_to action: :show
  end

  def statistics
    @statistics = database.base_product_statistics
    if @statistics.success?
      flash.now[:success] = 'Produktstatistik hämtad.'
    else
      flash.now[:error] = 'Något gick fel.'
    end
  end

  private

  def item_params
    {
        item: params[:item].to_unsafe_h.merge({
          required_group_permissions: group_params
        })
    }
  end

  def group_params
    groups = 0
    unless params[:group].nil?
      params[:group].each do |key, value|
        groups |= 1 << key.to_i
      end
    end

    groups
  end
end
