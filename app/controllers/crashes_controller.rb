class CrashesController < ApplicationController
  before_filter :find_app
  before_filter :find_crash, :only => [:show, :close]
  
  def show
    @env = YAML.load(@crash.environment)
  end
  
  def close
    if @crash.close
      flash[:success] = "Issue has been closed."
      redirect_to app_path(@app)
    else
      flash[:error] = "Unable to close the issue."
      redirect_to app_crash_path(@app, @crash)
    end
  end
end
