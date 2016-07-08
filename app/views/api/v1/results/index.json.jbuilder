json.bulletins @bulletins,
              partial: 'api/v1/bulletins/bulletin',
              as: :bulletin

json.attachments @attachments do |attachment|
  json.merge! attachment.as_json
end
