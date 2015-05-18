require_relative '../../lib/tee_shits_app'

class OrdersController < ApplicationController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  # TODO dry up this class using before/after blocks to wrap each route for error handling
  def create
    params.require(:email)
    params.require(:stripeToken)

    @app = TeeShits::App.create(params[:email])
    @app.create_order(params[:stripeToken])

    if @app.has_errors?
      flash[:alert] = "Uh oh! It seems like we had some trouble placing your order: #{@app.error.message}"
      redirect_to :back
    else
      flash[:notice] = "Awesome, you're order has been placed, you'll be getting funny looks in public before your know it!"
      redirect_to products_path
    end

  end
end
