class Admin::ReportsController < ApplicationController

  def index
    @reports = Report.all
  end

  def update
  end

end
