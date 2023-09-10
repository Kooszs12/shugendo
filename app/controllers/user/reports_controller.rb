class User::ReportsController < ApplicationController

  def create
    @place = Place.find(params[:place_id])
    @report = current_user.reports.new(place_id: @place.id)
    @report.save
  end

  def destroy
    @place = Place.find(params[:place_id])
    @report = current_user.reports.find_by(place_id: @place.id)
    @report.destroy
  end

end
