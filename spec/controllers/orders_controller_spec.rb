require 'rails_helper'
require_relative '../../lib/core/helpers/error'

describe OrdersController do
  describe 'POST create' do

    before(:each) do
      request.env['HTTP_REFERER'] = 'back_link'

      create(:product)

      expect_any_instance_of(TeeShits::App).to receive(:create_order)
    end

    it 'display a pleasant message when an order succeeds' do
      expect_any_instance_of(TeeShits::App).to receive(:errors?).and_return false

      post :create, email: '123@test.com', stripeToken: 'tok_123', quantity: 1, product_id: 1

      expect(flash[:notice]).to eq 'Awesome, you\'re order has been placed, you\'ll be getting funny looks in public before your know it!'
      expect(response.status).to eq 302
    end

    it 'display an error message when the order fails' do
      expect_any_instance_of(TeeShits::App).to receive(:errors?).and_return true
      expect_any_instance_of(TeeShits::App).to receive(:error).and_return TeeShits::Helpers::Error.new('jibberish error')

      post :create, email: '123@test.com', stripeToken: 'tok_123', quantity: 1, product_id: 1

      expect(flash[:alert]).to eq 'Uh oh! It seems like we had some trouble placing your order: jibberish error'
      expect(response.status).to eq 302
    end
  end
end
