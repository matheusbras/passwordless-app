# encoding: UTF-8
module SessionSpecHelper
  def current_user
    @current_user ||= create(:user)
  end

  def login!(user = current_user)
    session[:user_id] = user.id
  end
end

RSpec.configure do |config|
  config.include SessionSpecHelper, :type => :controller
  config.include SessionSpecHelper, :type => :helper
end

shared_examples_for :authentication_required do
  context :not_logged_in do
    before do
      do_action 
    end

    it { should redirect_to(root_url) }
    it { flash[:notice].should == "Você precisa estar autenticado..." }
  end
end