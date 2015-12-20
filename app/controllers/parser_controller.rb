class ParserController < ApplicationController
  def index
    @partners = Partner.all
  end
end
