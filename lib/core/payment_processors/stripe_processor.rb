require 'stripe'
require_relative '../payment_processor_base'
require_relative '../helpers/error'

module TeeShits
  module Base
    class StripeProcessor < PaymentProcessorBase

      def initialize(email)
        Stripe.api_key = Rails.application.secrets.stripe_api_key
        @currency      = 'usd'
        @errors        = Array.new
        @customer      = self.create_customer email
      end

      def create_customer(email)
        start_stripe_interaction {
          customer = Stripe::Customer.create(
            :email => email
          )

          customer
        }
      end

      def add_payment_option(token)
        start_stripe_interaction {
          @customer.source = token
          @customer.save
        }
      end

      def pre_authorize(amount)
        start_stripe_interaction {
          charge = Stripe::Charge.create(
            :amount      => amount,
            :currency    => @currency,
            :customer    => @customer.id,
            :description => "test charge 123", # TODO create real description using localization
            :capture     => false
          )

          @last_charge_id = charge.id
        }
      end

      # noinspection RubyArgCount
      def complete_charge(charge_id = nil)
        start_stripe_interaction {
          charge_id = charge_id.nil? ? @last_charge_id : charge_id
          ch        = Stripe::Charge.retrieve(charge_id)
          ch.capture
        }
      end

      def has_errors?
        !@errors.empty?
      end

      def raw_errors
        @errors
      end

      def error
        translate_error
      end

      private

      def translate_error
        # Grab the error
        e = @errors.pop

        # Translate it to something nice
        if e.is_a?(Stripe::CardError)
          body    = e.json_body
          err     = body[:error]
          message = "#{err[:message]}"
        elsif e.is_a?(Stripe::InvalidRequestError)
          message = "You have entered an invalid card" # TODO implement localization
        else
          message = "An error occurred completing your payment, please try again or contact us for support."
        end

        TeeShits::Helpers::Error.new(message)
      end

      def start_stripe_interaction
        begin
          yield
        rescue Stripe::StripeError => e
          @errors << e
        end
      end
    end
  end
end
