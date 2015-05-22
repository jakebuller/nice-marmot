require_relative '../../lib/tee_shits_app'

class OrdersController < ApplicationController
  protect_from_forgery with: :null_session,
                       if: proc { |c| c.request.format == 'application/json' }

  # TODO: dry up this class using before/after blocks to wrap each route for error handling
  def create
    validate_create_params

    @app = TeeShits::App.create(params[:email])
    @app.create_order(params[:stripeToken])

    if @app.has_errors?
      flash[:alert] = I18n.t 'orders.error', error: "#{@app.error.message}"
      redirect_to :back
    else
      flash[:notice] = I18n.t 'orders.success'
      redirect_to products_path
    end
  end

  private

  def validate_create_params
    params.require(:email)
    params.require(:stripeToken)
  end
end
