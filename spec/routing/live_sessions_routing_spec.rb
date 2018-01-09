require "rails_helper"

RSpec.describe LiveSessionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/live_sessions").to route_to("live_sessions#index")
    end

    it "routes to #new" do
      expect(:get => "/live_sessions/new").to route_to("live_sessions#new")
    end

    it "routes to #show" do
      expect(:get => "/live_sessions/1").to route_to("live_sessions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/live_sessions/1/edit").to route_to("live_sessions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/live_sessions").to route_to("live_sessions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/live_sessions/1").to route_to("live_sessions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/live_sessions/1").to route_to("live_sessions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/live_sessions/1").to route_to("live_sessions#destroy", :id => "1")
    end

  end
end
