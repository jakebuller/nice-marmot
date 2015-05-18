require_relative '../lib/core/payment_processors/stripe_processor'

module TeeShits
  class App
    def initialize(payment_processor)
      @payment_processor = payment_processor
      @error = nil
    end

    def has_errors?
      !@error.nil?
    end

    def error
      @error
    end

    def create_order(token)
      @payment_processor.add_payment_option(token)
      @payment_processor.pre_authorize 200

      if @payment_processor.has_errors?
        @error = @payment_processor.error
        return
      end

      # TODO create printful order

      @payment_processor.complete_charge

      if @payment_processor.has_errors?
        @error = @payment_processor.error
      end
    end

    def self.create(email)
      return self.new(TeeShits::Base::StripeProcessor.new(email))
    end
  end
end
