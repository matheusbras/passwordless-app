# encoding: UTF-8
require "spec_helper"

describe Notification do
  describe ".auth_link(user)" do
    let(:user) { create(:user, email: "batman@email.com") }
    let(:mailer) { Notification.auth_link(user) }

    it { lambda { Notification.auth_link(user).should_not raise_error } }
    it { mailer.subject.should == %{[Passwordless App] Aqui está seu link de acesso} }
    it { mailer.body.to_s.should == read_mail("notification/auth_link") }
    it { mailer.header['From'].to_s.should == "estagiario@passwordlessapp.com" }
    it { mailer.header['To'].to_s.should == "batman@email.com" }
    it { mailer.from.size.should == 1 }
    it { mailer.to.size.should == 1 }
    it { mailer.cc.should be_nil }
    it { mailer.bcc.should be_nil }
    it { mailer.multipart?.should be_false }
    it { mailer.charset.should == "UTF-8" }
    it { mailer.content_type.should == "text/html; charset=UTF-8" }
    it {
      expect {
        Notification.auth_link(user).deliver
      }.to change(ActionMailer::Base.deliveries, :size).by(1)
    }
  end

  def read_mail(name)
    filename = Rails.root.join('spec','fixtures',"#{name}.html")
    File.open(filename, 'w') {|f| f.write(mailer.body.to_s) } unless File.exists?(filename)
    File.read(filename)
  end
end
