class ApplicationController < ActionController::Base
  include Devise::Controllers::Helpers
  skip_forgery_protection
end
