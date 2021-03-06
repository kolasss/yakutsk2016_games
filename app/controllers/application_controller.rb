class ApplicationController < ActionController::API
  include Sorcery::Controller

  AVAILABLE_LOCALES ||= Rails.configuration.i18n.available_locales

  before_action :require_login, except: [:index, :show]

  private

    def not_authenticated
      head :unauthorized
      # redirect_to users_login_path, alert: "Войдите в систему!"
    end
end
