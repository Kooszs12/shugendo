class User::ReportsController < ApplicationController

  def create
    @place = Place.find(params[:place_id])
    @report = current_user.reports.new(place_id: @place.id)
    @report.save
  end

end
