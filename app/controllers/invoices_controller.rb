class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @originating_page = OriginatingPage.new(session[:originating_path] || invoices_path)

    set_invoice

    @client = @invoice.client
    @job_address = @invoice.job_address
    @invoice_items = InvoiceItem.where(invoice: @invoice)
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.job_address = Address.find(invoice_params[:job_address_id])
    @invoice.client = @invoice.job_address.client

    if @invoice.save!
      redirect_to invoice_path(@invoice), notice: 'The invoice was successfully saved!'
    else
      flash.now[:notice] = 'The invoice could not be saved!'
      render :new
    end
  end

  def edit
    set_invoice
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to client_path(@client), notice: 'The invoice was successfully updated!'
    else
      flash.now[:notice] = 'The invoice could not be updated!'
      render :edit
    end
  end

  def destroy
    set_invoice
    @invoice.update(deleted:  true)
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
    if @invoice.deleted?
      raise ActiveRecord::NotFound
    end
  end

  def invoice_params
    params.require(:invoice).permit(:id,
                                    :total,
                                    :performed_by,
                                    :job_date,
                                    :status,
                                    :job_address_id,
                                    :notes)
  end

end
