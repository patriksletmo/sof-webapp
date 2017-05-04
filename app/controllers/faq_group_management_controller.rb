class FaqGroupManagementController < NavigationController
  ## FAQ GROUPS

  def create_faq_group
    return if require_login!

    if request.post?
      response = database.create_faq_group item_params
      toast_response_message(response)

      redirect_to manage_faqs_url
    else
      render :new_faq_group
    end
  end

  def show_faq_group
    return if require_login!

    @faq_group = database.show_faq_group(params[:id])
    unless @faq_group.success?
      flash[:error] = @faq_group['message']
      redirect_to manage_faqs_url
    end
  end

  def update_faq_group
    return if require_login!

    response = database.update_faq_group params[:id], item_params
    toast_response_message(response)

    redirect_to manage_faqs_url
  end

  def delete_faq_group
    return if require_login!

    response = database.destroy_faq_group(params[:id])
    toast_response_message response

    redirect_back(fallback_location: root_url)
  end

  private

  def toast_response_message(response)
    if response.success?
      flash[:success] = response['message']
    else
      if response['message'].present?
        flash[:error] = response['message']
      else
        flash[:error] = 'Something went terribly wrong. Invalid response'
      end
    end
  end

  def item_params
    # Validation done on api-side
    params.to_unsafe_h
  end
end
