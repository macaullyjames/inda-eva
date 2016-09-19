class ChecksController < ApplicationController
  def index
    @org = org
    @repos = Repo.where(org: org)
    @query = params[:query]
    if @query.present?
      @repos = @repos.where("name like ?", "#{@query}")
    end
  end

  def check
    repo = Repo.find_by org: org, name: params[:repo]
    check_name = params[:check]
    unless repo and check_name == "isValidJava"
      return head 403
    end

    credentials = Rugged::Credentials::UserPassword.new(
      username: user.username,
      password: user.token
    )

    dir = Rails.root.join("repos", org, repo.name).to_s
    FileUtils.rm_rf dir
    FileUtils.mkdir_p dir
    Rugged::Repository.clone_at(
      "https://gits-15.sys.kth.se/#{org}/#{repo.name}.git",
      dir,
      credentials: credentials
    )

    passed = Dir.glob("#{dir}/**/*.java").all? do |file|
      Rails.logger.info "Running check `java io.evabot.IsValidJavaCheck #{file}`"
      system "java", "io.evabot.IsValidJavaCheck", file
    end

    status = passed ? "passed" : "failed"

    FileUtils.rm_rf dir

    check = Check.where(repo: repo, name: check_name).first_or_create
    check.update status: status
    render json: { status: status }
  end
end
