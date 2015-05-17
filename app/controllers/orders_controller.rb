require_relative '../../lib/tee_shits_app'

class OrdersController < ApplicationController
  # TODO dry up this class using before/after blocks to wrap each route for error handling
  def create
    @app = TeeShits::App.create
    @app.create_order

    if @app.has_errors?
      render json: { message: @app.error.message, error_code: @app.error.error_code }, status: :internal_server_error
    else
      render json: {}, status: :ok
    end

  end
end
