require_relative '../../core/payment_processors/stripe_processor'

module TeeShits
  module Models
    class Order
      attr_reader :errors
      def initialize(email, token, quantity, product)
        @payment_processor = TeeShits::Base::StripeProcessor.new(email)
        @error = nil
        @token = token
        @quantity = quantity
        @product = product
      end

      def create
        @payment_processor.add_payment_option(@token)
        @payment_processor.pre_authorize 200, payment_description

        if @payment_processor.errors?
          @error = @payment_processor.error
          return
        end

        # TODO: create printful order

        @payment_processor.complete_charge

        @error = @payment_processor.error if @payment_processor.errors?
      end

      def errors?
        !@error.nil?
      end

      private

      def payment_description
        "#{@product.name} x #{@quantity}"
      end
    end
  end
end
