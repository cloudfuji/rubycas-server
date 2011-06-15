require 'casserver/authenticators/base'

# warden isn't necessary right now since there's nothing related used directly
begin
  require 'warden'
rescue LoadError
  require 'rubygems'
  require 'warden'
end

class CASServer::Authenticators::WardenAuth < CASServer::Authenticators::Base

  def validate(credentials)
  	read_standard_credentials(credentials)
	
    return true if @request.env['warden'].authenticated?
	return false
  end

end
