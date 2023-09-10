class User::ReportsController < ApplicationController

  def create
    @place = Place.find(params[:place_id])
    @report = current_user.reports.new(place_id: @place.id)
    if @report.save
      @report.create(user: current_user, place: @place, content: '新しいレポートが作成されました')
    end
  end

  def destroy
    @place = Place.find(params[:place_id])
    @report = current_user.reports.find_by(place_id: @place.id)
    @report.destroy
  end

end
