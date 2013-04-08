# encoding: UTF-8
require 'spec_helper'

describe ApplicationController do
  let!(:user) { create(:user) }

  describe "current_user helper" do
    context "with user logged in" do
      before do
        session[:user_id] = user.id
      end

      it "returns the logged user" do
        controller.send(:current_user).should eq(user)
      end
    end

    context "without user logged in" do
      it "returns nil" do
        controller.send(:current_user).should be_nil
      end
    end

    context "can't find the user" do
      before do
        session[:user_id] = "#77"
      end

      it "returns nil" do
        controller.send(:current_user).should be_nil
      end

      it "unsets the session[:user_id]" do
        controller.send(:current_user)
        session[:user_id].should be_nil
      end
    end
  end

  describe "user_signed_in? helper" do
    context "with user logged in" do
      before do
        session[:user_id] = user.id
      end

      it "returns true" do
        controller.send(:user_signed_in?).should be_true
      end
    end

    context "without user logged in" do
      it "returns false" do
        controller.send(:user_signed_in?).should be_false
      end
    end
  end

  describe "authenticate! filter" do
    context "with user logged in" do
      before do
        session[:user_id] = user.id
      end

      it "returns true" do
        controller.send(:authenticate!).should be_true
      end
    end
  end
end