module ApplicationHelper

  # ソート機能class
  def sort_change(sort)
    params[:sort_option] == sort ? 'text-success' : ''
  end

end
