class RawEmailsController < ApplicationController
  def index
    @raw_emails = RawEmail.all
  end

  def new
    @raw_email = RawEmail.new
  end

  def create
    @raw_email = RawEmail.new(raw_email_params)

    if @raw_email.save
      flash[:notice] = "Successfully created raw email"
      redirect_to @raw_email
    else
      flash[:error] = "Error saving raw email"
      render 'new'
    end
  end

  def show
    @raw_email = RawEmail.find(params[:id])
  end

  def edit
    @raw_email = RawEmail.find(params[:id])
  end

  def update
    @raw_email = RawEmail.find(params[:id])

    if @raw_email.update_attributes(raw_email_params)
      redirect_to @raw_email
    else
      flash[:error] = "Error updating raw email. Please try again."
      render :edit
    end
  end

  def destroy
    @raw_email = RawEmail.find(params[:id])
    @raw_email.destroy
    redirect_to raw_emails_path, notice: "Successfully deleted raw email"
  end

  def raw_email_params
    params.require(:raw_email).permit(:raw_email)
  end
end
