require 'spec_helper'

describe SessionsController do
  it "#routes to create action" do
    get("/auth/hash").should route_to("sessions#create", token: "hash")
    auth_path("hash").should eq("/auth/hash")
  end

  it "#routes to delete action" do
    delete("/logout").should route_to("sessions#destroy")
    logout_path.should eq("/logout")
  end
end
