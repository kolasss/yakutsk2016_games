module Sorcery
  module Model
    module Submodules
      module JwtToken
        def self.included(base)
          # base.send(:include, InstanceMethods)
          base.extend(ClassMethods)
        end

        module ClassMethods

          def find_by_auth_id auth_id
            joins(:authentications).merge(Authentication.where id: auth_id).first
          end
        end

        # module InstanceMethods
        #   # # You shouldn't really use this one yourself - it's called by the controller's 'force_forget_me!' method.
        #   # def force_forget_me!
        #   #   config = sorcery_config
        #   #   self.sorcery_adapter.update_attributes(config.remember_me_token_attribute_name => nil,
        #   #                               config.remember_me_token_expires_at_attribute_name => nil)
        #   # end
        # end
      end
    end
  end
end
