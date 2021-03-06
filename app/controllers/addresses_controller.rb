class AddressesController < AuthenticatedController
  def new
    @address = Address.new
    @client = Client.find(params[:client_id])
  end

  def create
    @address = Address.new(address_params)
    @client = Client.find(params[:client_id])

    @address.client = @client

    if @address.save
      redirect_to @client, notice: 'Address was successfully added!'
    else
      flash.now[:notice] = 'There was a problem saving the address!'
      render :new
    end
  end

  def edit
    set_address
    @client = @address.client
  end

  def update
    set_address
    @client = @address.client
    if @address.update(address_params)
      redirect_to @client, notice: 'Address was successfully updated!'
    else
      flash.now[:notice] = 'There was a problem saving the address!'
      render :edit
    end
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip, :position, :is_job_address?, :client_id)
  end
end
