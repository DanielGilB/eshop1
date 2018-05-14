class Admin::AuthenticatedController < ApplicationController
  before_filter :require_user
end
