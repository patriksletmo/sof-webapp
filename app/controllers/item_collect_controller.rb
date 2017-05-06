class ItemCollectController < NavigationController
  def index
    return if require_login!

    if params['response'].is_a? Array
      if params['response'].count == 1
        @user = database.retrieve_user_with_items params['response'].first['id']
      elsif params['response'].count > 1
        @users = []
        params['response'].each do |user|
          user = database.single_user user['id']
          @users.append user
        end
      end
    elsif params['response'].present?
      flash.now[:error] = params['response']['message']
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
