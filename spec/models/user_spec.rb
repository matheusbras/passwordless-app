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

end
