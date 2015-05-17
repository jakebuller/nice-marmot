require 'stripe'
require_relative '../payment_processor_base'
require_relative '../helpers/error'

module TeeShits
  module Base
    class StripeProcessor < PaymentProcessorBase

      def initialize(customer_id)
        Stripe.api_key = Rails.application.secrets.stripe_api_key
        @customer_id   = customer_id
        @currency      = 'usd'
        @errors = Array.new
      end

      def pre_authorize(amount)
        start_stripe_interaction {
          charge = Stripe::Charge.create(
            :amount      => amount,
            :currency    => @currency,
            :customer    => @customer_id,
            :description => "", # TODO create real description using localization
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
        TeeShits::Helpers::Error.new('abc123')
      end

      def start_stripe_interaction
        begin
          yield
        rescue Stripe::CardError => e
          @errors << e
          # Since it's a decline, Stripe::CardError will be caught
          # body = e.json_body
          # err  = body[:error]
          #
          # puts "Status is: #{e.http_status}"
          # puts "Type is: #{err[:type]}"
          # puts "Code is: #{err[:code]}"
          # param is '' in this case
          # puts "Param is: #{err[:param]}"
          # puts "Message is: #{err[:message]}"
        rescue Stripe::InvalidRequestError => e
          @errors << e
          # Invalid parameters were supplied to Stripe's API
          # TODO complete implementation
        rescue Stripe::AuthenticationError => e
          @errors << e
          # Authentication with Stripe's API failed
          # (maybe you changed API keys recently)
          # TODO complete implementation
        rescue Stripe::APIConnectionError => e
          @errors << e
          # Network communication with Stripe failed
          # TODO complete implementation
        rescue Stripe::StripeError => e
          @errors << e
          # Display a very generic error to the user, and maybe send
          # yourself an email
          # TODO complete implementation
        rescue => e
          @errors << e
          # Something else happened, completely unrelated to Stripe
          # TODO complete implementation
        end
      end
    end
  end
end
