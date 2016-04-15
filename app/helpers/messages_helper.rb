module MessagesHelper
  def flash_messages
    safe_join flash.map { |type, msg| message(type, msg) }
  end

  private

    def message type = '', msg
      # return if type == 'timedout'

      # msg = safe_join([ msg, icon_close(:alert) ])
      close_button = content_tag :button, class: 'close', data: { dismiss: '' } do
        'x'
      end
      msg = safe_join([ msg, close_button ])

      content_tag :div, msg, class: "alert fade in #{message_class type}"
    end

    def message_class type
      case type
        when 'info'    then 'alert-info'
        when 'notice'  then 'alert-success'
        when 'warning' then 'alert-warning'
        when 'alert'   then 'alert-danger'
        when 'danger'  then 'alert-danger'
        else 'alert-info'
      end
    end
end
