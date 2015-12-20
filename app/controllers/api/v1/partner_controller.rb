class Api::V1::PartnerController < ApplicationController

  def index
    @partners = Partner.all
    render :json => @partners
  end

  def show
    @partner = Partner.find params[:id]
    render :json => @partner
  end

  def create
    @partner = Partner.new partner_params

    begin
      task = "#{@partner.xml_type}Worker".constantize
    rescue NameError
      return render :status => 422, :json => [errors: "Type #{@partner.xml_type} not found."]
    end

    unless @partner.save!
      return render :status => 422, :json => [errors: @partner.errors.full_messages]
    end

    task.perform_async(@partner.xml_url, @partner.id)

    render :json => @partner
  end

  def update
    @partner = Partner.find params[:id]

    begin
      task = "#{partner_params[:xml_type]}Worker".constantize
    rescue NameError
      return render :status => 422, :json => [errors: "Type #{partner_params[:xml_type]} not found."]
    end

    unless @partner.update_attributes partner_params
      return render :status => 422, :json => [errors: @partner.errors.full_messages]
    end

    task.perform_async(@partner.xml_url, @partner.id)

    render :json => @partner
  end

  def destroy
    @partner = Partner.find params[:id]
    @partner.destroy
    render :json => @partner
  end

  def partner_params
    params.require(:partner).permit(:xml_url, :xml_type)
  end
end
