class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  AVAILABLE_LOCALES ||= Rails.configuration.i18n.available_locales

  before_action :require_login, except: [:index, :show]
end
