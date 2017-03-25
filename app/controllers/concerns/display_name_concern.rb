module DisplayNameConcern
  extend ActiveSupport::Concern

  NAG_CONTROLLER = 'user'
  NAG_ACTION = 'nag_display_name'

  included do
    before_action :ensure_user_has_display_name
  end

  def ensure_user_has_display_name
    unless current_user.nil?
      if current_user['display_name'].nil? and not is_nag_path?
        redirect_to controller: NAG_CONTROLLER, action: NAG_ACTION
      end
    end
  end

  private

  def is_nag_path?
    controller_name == NAG_CONTROLLER and action_name == NAG_ACTION
  end

end