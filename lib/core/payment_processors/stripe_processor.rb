require 'stripe'
require_relative '../helpers/error'

module TeeShits
  module Base
    class StripeProcessor
      attr_reader :errors

      def initialize(email)
        Stripe.api_key = Rails.application.secrets.stripe_api_key
        @currency      = 'usd'
        @errors        = []
        @customer      = create_customer email
      end

      def create_customer(email)
        start_stripe_interaction do
          customer = Stripe::Customer.create(
            email: email
          )

          customer
        end
      end

      def add_payment_option(token)
        start_stripe_interaction do
          @customer.source = token
          @customer.save
        end
      end

      def pre_authorize(amount, description)
        start_stripe_interaction do
          charge = Stripe::Charge.create(
            amount:      amount,
            currency:    @currency,
            customer:    @customer.id,
            description: I18n.t('payment.description', description: description),
            capture:     false
          )

          @last_charge_id = charge.id
        end
      end

      # noinspection RubyArgCount
      def complete_charge(charge_id = nil)
        start_stripe_interaction do
          charge_id = charge_id.nil? ? @last_charge_id : charge_id
          ch        = Stripe::Charge.retrieve(charge_id)
          ch.capture
        end
      end

      def errors?
        !@errors.empty?
      end

      def error
        translate_error
      end

      private

      def translate_error
        # Grab the error
        e = @errors.pop

        message = error_to_s e
        TeeShits::Helpers::Error.new(message)
      end

      def error_to_s(e)
        # Translate it to something nice
        if e.is_a?(Stripe::CardError)
          body    = e.json_body
          err     = body[:error]
          message = "#{err[:message]}"
        elsif e.is_a?(Stripe::InvalidRequestError)
          message = I18n.t 'payment.error.invalid_request'
        else
          message = I18n.t 'payment.error.generic'
        end

        message
      end

      def start_stripe_interaction
        yield
      rescue Stripe::StripeError => e
        @errors << e
      end
    end
  end
end
