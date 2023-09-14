class User::ReportsController < ApplicationController

  # アクセス制限
  before_action :authenticate_user!

  def create
    @place = Place.find(params[:place_id])
    @report = current_user.reports.new(place_id: @place.id)
    @report.save
  end

end
