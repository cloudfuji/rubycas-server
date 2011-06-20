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

    # TODO allow set the field name in the config.yml file
    # That should allow to choose between email or username. LOW PRIORITY
      
    if @request['warden'].authenticated?
        return true
    elsif user=User.find_by_email(@username) and user.respond_to?(:valid_password?)
      # Well you could just check the find count. But you'll be making the find call again in this block
      # Oh an the single equals in the condition is for a purpose :)
      
      return true if user.valid_password?(@password)
    end
    
    # default return false
    false
  end

end
