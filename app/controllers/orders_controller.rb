require_relative '../../lib/tee_shits_app'

class OrdersController < ApplicationController
  protect_from_forgery with: :null_session,
                       if: proc { |c| c.request.format == 'application/json' }

  before_action :set_product, only: [:create]

  # TODO: dry up this class using before/after blocks to wrap each route for error handling
  def create
    validate_create_params

    @app = TeeShits::App.new
    @app.create_order(params[:email], params[:stripeToken], params[:quantity], @product)

    if @app.errors?
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
    params.require(:product_id)
    params.require(:quantity)
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end
