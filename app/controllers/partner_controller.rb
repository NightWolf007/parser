class PartnerController < ApplicationController
  def index
    @partners = Partner.all
  end

  def show
    @partner = Partner.find params[:id]
  end

  def new
    @partner = Partner.new
  end

  def update
    @partner = Partner.find params[:id]
  end
end
