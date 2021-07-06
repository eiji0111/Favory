class Public::ContactsController < ApplicationController
  before_action :set_contact, only: [:confirm, :create]
  
  def new
    @contact = Contact.new
  end

  def confirm
    render :new unless @contact.valid?
  end
  
  def back
    redirect_to new_contact_path, alert: "はじめから入力してください"
  end

  def create
    if params[:back].present?
      render :new
      return
    end
    
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to complete_contacts_path
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
