module JsonValidation
  extend ActiveSupport::Concern

  included do
    json_schema_properties ||= Rails.configuration.i18n.available_locales.map do |locale|
      [
        locale,
        {
          type: "string",
          minLength: 1
        }
      ]
    end.to_h

    JSON_SCHEMA ||= {
      type: "object",
      properties: json_schema_properties
    }

    JSON_VALIDATION ||= {
      message: -> (errors) { errors },
      schema: JSON_SCHEMA,
      options: {
        strict: true
      }
    }
  end
end
