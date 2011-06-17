require "#{File.expand_path(File.dirname(__FILE__))}/base"

# warden isn't necessary right now since there's nothing related used directly
begin
  require 'warden'
rescue LoadError
  require 'rubygems'
  require 'warden'
end

class CASServer::Authenticators::DeviseAuth < CASServer::Authenticators::Base

  def validate(credentials)

  	read_standard_credentials(credentials)
	  $LOG.debug(@request['warden'].inspect)

    # set the field name in the config.yml file    
    return true if (@request['warden'].authenticated? or User.find_by_email(@username).valid_password?(@password))
	  false
  end

end
