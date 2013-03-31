class ApplicationController < ActionController::Base
  protect_from_forgery
  ensure_security_headers # See more: https://github.com/twitter/secureheaders

end
