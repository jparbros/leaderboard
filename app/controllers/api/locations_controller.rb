class Api::LocationsController < ApplicationController

  def countries
    render json: Carmen::Country.all.map {|country| {name: country.name, alpha_2_code: country.alpha_2_code} }
  end

  def regions
    @regions = Carmen::Country.coded(params[:country]).subregions
    render json: @regions.map {|region| {name: region.name, code: region.code}}
  end
end
