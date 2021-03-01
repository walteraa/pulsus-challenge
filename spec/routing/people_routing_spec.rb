require "rails_helper"

RSpec.describe Api::V1::PeopleController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/people").to route_to("api/v1/people#index")
    end

    it "routes to #show" do
      expect(get: "api/v1/people/1").to route_to("api/v1/people#show", id: "1")
    end

  end
end
