# encoding: UTF-8
require 'spec_helper'

describe SecretController do

  describe "GET 'index'" do
    def do_action
      get :index
    end

    context "not logged in" do
      before do
        do_action
      end

      it "redirects to root_path" do
        should redirect_to(root_path)
      end

      it "sets a flash message" do
        should set_the_flash.to("Você precisa estar autenticado...")
      end
    end

    context "logged in" do
      before do
        login!
        do_action
      end

      it { should render_template(:index) }
      it { should render_with_layout(:application) }
      it { response.should be_success }
    end
  end
end
