class FaqController < NavigationController
  def index
    @faq_group = database.faq_group
    unless @faq_group.success?
      render status: 403
    end

    puts '>>>>>PARAMS<<<<<<'
    puts params

    if params[:lang] == 'eng'
      @lang = 'eng'
    end
  end
end