class ApplicationController < ActionController::Base
  protect_from_forgery
  
  protected
  
  def find_app
    @app = App.find_by_id(params[:app_id] || params[:id])
    if @app.nil?
      flash[:error] = "Unable to find app."
      return redirect_to apps_path
    end
  end
  
  def find_crash
    @crash = @app.crashes.find_by_id(params[:crash_id] || params[:id])
    if @crash.nil?
      flash[:error] = "Unable to find the record."
      return redirect_to app_path(@app)
    end
  end
end
