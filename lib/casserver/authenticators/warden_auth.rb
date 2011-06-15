require "#{File.expand_path(File.dirname(__FILE__))}/base"

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
	$LOG.debug(@request.inspect)
    return true if @request['warden'].authenticated?
	return false
  end

end
