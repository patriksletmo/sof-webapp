class FaqManagementController < NavigationController
  def index
    return if require_login!

    @faq_groups = database.faq_group
    @faqs = database.faq
    unless @faq_groups.success? && @faqs.success?
      render status: 403
    end
  end

  ## FAQ

  def create_faq
    return if require_login!

    if request.post?
      puts item_params
      response = database.create_faq item_params
      check_response(response)

      redirect_to manage_faqs_url
    else
      @faq_groups = database.faq_group
      unless @faq_groups.success?
        render status: 403
      end

      render :new_faq
    end
  end

  def show_faq
    return if require_login!

    @faq_groups = database.faq_group
    @faq = database.show_faq(params[:id])
    unless @faq.success?
      flash[:error] = @faq['message']
      redirect_to manage_faqs_url
    end
    unless @faq_groups.success?
      flash[:error] = @faq_groups['message']
      redirect_to manage_faqs_url
    end
  end

  def update_faq
    return if require_login!

    response = database.update_faq params[:id], item_params
    check_response(response)

    redirect_to manage_faqs_url
  end

  def delete_faq
    return if require_login!

    response = database.destroy_faq(params[:id])
    check_response(response)

    redirect_back(fallback_location: root_url)
  end

  ## FAQ GROUPS

  def create_faq_group
    return if require_login!

    if request.post?
      response = database.create_faq_group item_params
      check_success(response)

      redirect_to manage_faqs_url
    else
      render :new_faq_group
    end
  end

  def show_faq_group
    return if require_login!

    @faq_group = database.show_faq(params[:id])
    unless @faq_group.success?
      flash[:error] = @faq_group['message']
      redirect_to manage_faqs_url
    end
  end

  def update_faq_group
    return if require_login!

    response = database.update_faq_group params[:id], item_params
    check_response(response)

    redirect_to manage_faqs_url
  end

  def delete_faq_group
    return if require_login!

    response = database.destroy_faq_group(params[:id])
    check_success response

    redirect_back(fallback_location: root_url)
  end

  private

  def check_success(response)
    if response.success?
      flash[:success] = response['message']
    else
      flash[:error] = response['message']
    end
  end

  def item_params
    # Validation done on api-side
    params.to_unsafe_h
  end
end
