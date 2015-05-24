require_relative '../lib/domain/models/order'

module TeeShits
  class App
    def create_order(email, token, quantity, product)
      @order = TeeShits::Models::Order.new(email, token, quantity, product)
      @order.create
    end

    def errors?
      @order.errors?
    end

    def error
      @order.error
    end
  end
end
