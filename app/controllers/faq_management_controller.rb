class FaqManagementController < NavigationController
  def create_faq
    response = database.create_faq item_params
    if response.success?
      flash[:success] = response.message
    else
      flash[:error] = response.message
    end

    redirect_back(fallback_location: root_path)
  end

  def delete_faq

  end

  def create_faq_group
    response = database.create_faq_group item_params
    if response.success?
      flash[:success] = response.message
    else
      flash[:error] = response.message
    end

    redirect_back(fallback_location: root_path)
  end

  def delete_faq_group

  end

  private

  def item_params
    # Validation done on api-side
    params.to_unsafe_h
  end
end
