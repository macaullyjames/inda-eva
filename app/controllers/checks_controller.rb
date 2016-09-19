class ChecksController < ApplicationController
  def index
    @repos = Repo.where(org: org)
    @query = params[:query]
    if @query.present?
      @repos = @repos.where("name like ?", "#{@query}")
    end
  end
end
