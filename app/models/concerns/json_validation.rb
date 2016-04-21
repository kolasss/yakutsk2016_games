module JsonValidation
  extend ActiveSupport::Concern

  included do
    JSON_SCHEMA ||= {
      type: "object",
      required: Rails.configuration.i18n.available_locales
    }

    JSON_VALIDATION ||= {
      message: -> (errors) { errors },
      schema: JSON_SCHEMA
    }
  end
end
