# encoding: UTF-8
require 'spec_helper'

describe SessionsController do
  describe "GET 'create'" do
    let!(:user) { create(:user, email: "booker@email.com", id: 999) }

    def do_action
      get :create, token: token
    end

    context "unautorized" do
      def token
        "invalid-token"
      end

      context :regular do
        before do
          do_action
        end

        it { should redirect_to(root_url) }
        it { should set_the_flash.to("Acesso inválido... recupere sua senha.") }
      end

      context :complex do
        it "does not put the user_id on session" do
          expect do
            do_action
          end.to_not change { session[:user_id] }
        end
      end
    end

    context "authorized" do
      def token
        user.access_token
      end

      context :regular do
        before do
          do_action
        end

        it { should redirect_to(new_user_path) }
        it { should set_the_flash.to("Você está online! :)") }
      end

      context :complex do
        it "sets the session with the user id" do
          expect do
            do_action
          end.to change { session[:user_id] }.from(nil).to(999)
        end
      end
    end
  end

  describe "DELETE 'destroy'" do
    def do_action
      delete :destroy
    end

    context "logged in" do
      before do
        login!
      end

      context :regular do
        before do
          do_action
        end

        it { should set_the_flash.to("Volte em breve!") }
        it { should redirect_to(root_url) }
      end
      
      context :complex do
        it "changes the session from user.id to nil" do
          expect do
            do_action
          end.to change { session[:user_id] }.from(current_user.id).to(nil)
        end
      end
    end
  end
end
