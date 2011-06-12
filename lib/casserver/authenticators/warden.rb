require 'casserver/authenticators/base'

# warden isn't necessary right now since there's nothing related used directly
begin
  require 'warden'
rescue LoadError
  require 'rubygems'
  require 'warden'
end

class CASServer::Authenticators::WardenAuth < CASServer::Authenticators::Base
  def self.setup(options)
      # if setting other settings in the config.yml, do checks here
  end

  def validate(credentials)
    env['warden'].authenticated!

    if env['warden'].authenticated?
        true
    else
        false
    end
  end

end
