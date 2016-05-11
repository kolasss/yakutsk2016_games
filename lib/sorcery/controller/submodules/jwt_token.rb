module Sorcery
  module Controller
    module Submodules
      module JwtToken
        def self.included(base)
          base.send(:include, InstanceMethods)
          Config.login_sources << :login_from_jwt_token
        end

        module InstanceMethods

          def encode_auth_token auth
            AuthToken.encode({ auth_id: auth.id })
          end

          protected

            def current_auth_by_token
              current_user.authentications.find decoded_auth_token[:auth_id]
            end

            def login_from_jwt_token
              return false unless auth_id_included_in_auth_token?
              @current_user = user_class.find_by_auth_id(decoded_auth_token[:auth_id])
            end

            # Authentication Related Helper Methods
            # ------------------------------------------------------------
            def auth_id_included_in_auth_token?
              http_auth_token && decoded_auth_token && decoded_auth_token[:auth_id]
            end

            # Raw Authorization Header token (json web token format)
            # JWT's are stored in the Authorization header using this format:
            # Bearer somerandomstring.encoded-payload.anotherrandomstring
            def http_auth_token
              @http_auth_token ||= if request.headers['Authorization'].present?
                                     request.headers['Authorization'].split(' ').last
                                   end
            end

            # Decode the authorization header token and return the payload
            def decoded_auth_token
              @decoded_auth_token ||= AuthToken.decode(http_auth_token)
            end
        end

      end
    end
  end
end
