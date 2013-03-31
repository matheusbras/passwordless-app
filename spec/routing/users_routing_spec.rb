# encoding: UTF-8
require 'spec_helper'

describe UsersController do
  it "#routes to new action" do
    get("/users/new").should route_to("users#new")
  end

  it "#routes to new action" do
    post("/users").should route_to("users#create")
  end
end