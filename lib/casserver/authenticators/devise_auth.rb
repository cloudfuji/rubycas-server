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
  	
    # TODO allow set the field name (email/username) in the config.yml file. LOW PRIORITY
    
    user = User.find_by_email(@username)
    
    # to check if find didn't return nil. can also do with !nil?
    if user.respond_to?(:valid_password?) and user.valid_password?(@password)
      return true
    end

    false
  end

end
