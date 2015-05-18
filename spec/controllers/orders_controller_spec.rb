require 'rails_helper'
require_relative '../../lib/core/helpers/error'

describe OrdersController do
  describe "POST create" do

    before(:each) do
      request.env["HTTP_REFERER"] = "back_link"
    end

    it "display a pleasant message when an order succeeds" do

      app = instance_double(TeeShits::App)
      expect(app).to receive(:create_order)
      expect(app).to receive(:has_errors?).and_return false
      expect(TeeShits::App).to receive(:create).and_return(app)

      post :create, email: '123@test.com', stripeToken: 'tok_123'

      expect(flash[:notice]).to eq "Awesome, you're order has been placed, you'll be getting funny looks in public before your know it!"
      expect(response.status).to eq 302
    end

    it "display an error message when the order fails" do

      app = instance_double(TeeShits::App)
      expect(app).to receive(:create_order)
      expect(app).to receive(:has_errors?).and_return true
      expect(app).to receive(:error).and_return(TeeShits::Helpers::Error.new('jibberish error'))
      expect(TeeShits::App).to receive(:create).and_return(app)

      post :create, email: '123@test.com', stripeToken: 'tok_123'

      expect(flash[:alert]).to eq  "Uh oh! It seems like we had some trouble placing your order: jibberish error"
      expect(response.status).to eq 302
    end
  end
end
