class Public::ContactsController < ApplicationController
  before_action :set_contact, only: [:confirm, :back, :create]
  
  def new
    @contact = Contact.new
  end

  def confirm
    if @contact.invalid?
      render :new
    end
  end
  
  def back
    render :new
  end
  
  def create
    if @contact.save
      redirect_to complete_contact_path
    else
      render :new
    end
  end

  def complete
  end
  
  private
  
  def set_contact
    @contact = Contact.new(contact_params)
  end
  
  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
