module InternationalizationConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_request_language
  end

  def change_language
    cookies[:lang] = params[:lang]
    redirect_back fallback_location: {controller: :frontpage, action: :index}
  end

  def set_request_language
    I18n.locale = cookies[:lang] || I18n.default_locale
  end
end