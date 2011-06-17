require "#{File.expand_path(File.dirname(__FILE__))}/base"

# warden isn't necessary right now since there's nothing related used directly
begin
  require 'warden'
  require 'devise'
rescue LoadError
  require 'rubygems'
  require 'warden'
  require 'devise'
end

class CASServer::Authenticators::WardenAuth < CASServer::Authenticators::Base

  class DeviseStrategy < Devise::Strategies::Authenticatable    
    def authenticate!
      resource = valid_password? && mapping.to.find_for_database_authentication(authentication_hash)

      if validate(resource){ resource.valid_password?(password) }
        true
      elsif !halted?
        false
      else
        false  
      end
    end
  end

  def validate(credentials)
    Warden::Strategies.add(:devise_strategy, DeviseStrategy)
  
  	read_standard_credentials(credentials)
  	params = {:username=>@username, :password=>@password}
	  $LOG.debug(params)
    
    return true if @request['warden'].authenticated?
	  @request['warden'].authenticate
  end

end
