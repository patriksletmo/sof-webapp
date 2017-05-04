class FaqManagementController < NavigationController
  def index
    return if require_login!

    @faq_groups = database.faq_groups
    @faqs = database.faqs
    unless @faq_groups.success? && @faqs.success?
      render status: 403
    end
  end

  def create_faq
    return if require_login!

    if request.post?
      response = database.create_faq item_params
      toast_response_message(response)

      redirect_to manage_faqs_url
    else
      @faq_groups = database.faq_groups
      unless @faq_groups.success?
        render status: 403
      end

      render :new_faq
    end
  end

  def show_faq
    return if require_login!

    @faq_groups = database.faq_groups
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
    toast_response_message(response)

    redirect_to manage_faqs_url
  end

  def delete_faq
    return if require_login!

    response = database.destroy_faq(params[:id])
    toast_response_message(response)

    redirect_back(fallback_location: root_url)
  end


  private

  def item_params
    # Validation done on api-side
    params.to_unsafe_h
  end
end
