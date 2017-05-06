class ItemCollectController < NavigationController
  def index
    return if require_login!

    if params[:id].present?
      @user = database.retrieve_user_with_items params[:id]
    end
  end

  def collect
    return if require_login!

    response = database.collect_user_items(params[:id], params[:collected_ids])
    if response.success?
      flash[:success] = 'Varor utlämnade'
    else
      flash[:error] = 'KUNDE INTE LÄMNA UT VAROR!'
    end

    redirect_to action: :index, id: params[:id]
  end
end
