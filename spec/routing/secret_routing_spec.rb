require 'spec_helper'

describe SecretController do
  it "#routes to index" do
    get("/secret_page").should route_to("secret#index")
    secret_page_path.should eq("/secret_page")
  end
end
