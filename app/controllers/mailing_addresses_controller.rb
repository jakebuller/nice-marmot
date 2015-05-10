class MailingAddressesController < ApplicationController
  def add
    begin
      MailingAddress.create(mailing_address_params)
    rescue => e
      flash[:alert] = "Whoops, seems like that didn't work! Try again or contact us for support"
      logger.error "#{e.inspect}"
      redirect_to root_url and return
    end

    flash[:notice] = "Awesome, you've been added to our mailing list!"
    redirect_to root_url
  end

  def mailing_address_params
    params.require(:mailing_address).permit(:email)
  end
end
