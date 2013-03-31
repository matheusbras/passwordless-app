# encoding: UTF-8
require 'spec_helper'

describe UsersController do

  describe "GET 'new'" do
    before do
      get :new
    end

    it { response.should be_success }
    it { should render_template(:new) }
    it { should render_with_layout(:application) }
    it { assigns(:user).should be_an_instance_of(User) }
  end

  describe "POST 'create'" do
    def do_action
      post :create, params
    end

    context "valid request" do
      let(:params) { { user: { email: "john@doe.com" } } }

      it "creates a new User" do
        expect do
          do_action
        end.to change { User.count }.by(1)
      end

      it "generates an access_token for the user" do
        do_action
        User.last.access_token.should_not be_empty
      end

      it "redirects to new action" do
        do_action
        should redirect_to new_user_path
      end

      it "sets a flash message" do
        do_action
        should set_the_flash.to("Agora olha teu email lá! :)")
      end
    end

    context "invalid request" do
      let(:params) { { user: { email: "" } } }

      it "renders :new" do
        do_action
        should render_template(:new)
      end
    end
  end

end
