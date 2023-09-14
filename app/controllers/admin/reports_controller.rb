class Admin::ReportsController < ApplicationController

  # アクセス制限
  before_action :authenticate_admin!

  def index
    @reports = Report.all
  end

end
