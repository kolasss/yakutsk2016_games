class Api::ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  AVAILABLE_LOCALES ||= Rails.configuration.i18n.available_locales
end
