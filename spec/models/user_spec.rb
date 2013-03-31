require 'spec_helper'

describe User do
  describe "mass assignment" do
    it { should_not allow_mass_assignment_of(:access_token) }
  end

  describe "validations" do
    describe "of presence" do
      [:email, :access_token].each do |attr|
        it { should validate_presence_of(attr) }
      end
    end

    describe "of uniqueness" do
      it { should validate_uniqueness_of(:email) }
    end

    describe "of format" do
      context "Email" do
        it { should_not allow_value("e.com", "e@c", "email").for(:email) }
      end
    end
  end

  describe ".generate_token" do
    before do
      SecureRandom.stub(:hex).and_return("--token-1--", "--token-2--")
    end

    it { User.generate_token.should eq("--token-1--") }
  end

  describe "#save_and_generate_token" do
    before do
      SecureRandom.stub(:hex).and_return("--token-1--", "--token-2--")
    end

    context "with a new User" do
      let(:new_user) { build(:user, email: "jonh@doe.com", access_token: nil) }

      it "persists the user" do
        new_user.save_and_generate_token
        new_user.should be_persisted
      end

      it "generates an access_token" do
        expect do
          new_user.save_and_generate_token
        end.to change { new_user.access_token }.from(nil).to("--token-1--")
      end
    end

    context "with a new User, but same token" do
      let!(:existing_user) { create(:user, access_token: "--token-1--") }
      let(:new_user) { build(:user, email: "jonh@doe.com", access_token: nil) }

      it "persists the user" do
        new_user.save_and_generate_token
        new_user.should be_persisted
      end

      it "generates an access_token" do
        expect do
          new_user.save_and_generate_token
        end.to change { new_user.access_token }.from(nil).to("--token-2--")
      end
    end

    context "with an existing User" do
      let!(:existing_user) { create(:user, access_token: "--existing-token--") }

      it "generates a new token" do
        expect do
          existing_user.save_and_generate_token
        end.to change { existing_user.access_token }.from("--existing-token--").to("--token-1--")
      end
    end
  end

  describe ".acess_token_exists?(token)" do
    let!(:user) { create(:user) }

    it { User.access_token_exists?("--token--").should be_true }
    it { User.access_token_exists?("another-auth-token").should be_false }
  end
end
