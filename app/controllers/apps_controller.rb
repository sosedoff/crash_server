class AppsController < ApplicationController
  before_filter :find_app, :except => [:index, :new, :create, :exception]
  
  def index
    @apps = App.all
  end
  
  def show
    @active_issues = @app.crashes.active
    @closed_issues = @app.crashes.closed
  end
  
  def new
    @app = App.new
  end
  
  def create
    @app = App.new(params[:app])
    if @app.save
      flash[:success] = "New app has been created."
      redirect_to app_path(@app)
    else
      flash[:error] = "Unable to create app."
      render :new
    end
  end
  
  def update
    if @app.update_attributes(params[:app])
      flash[:success] = "Application has been updated."
      return redirect_to app_path(@app)
    else
      flash[:error] = "Unable to update information."
      render :edit
    end
  end
  
  def destroy
    @app.destroy
    if @app.destroyed?
      flash[:success] = "App has been deleted."
    else
      flash[:error] = "App could not be deleted."
    end
    redirect_to apps_path
  end
  
  # Regenerate API key
  def generate_key
    old = @app.api_key
    @app.reset_api_key!
    if @app.api_key != old
      flash[:success] = "API key has been changed."
    else
      flash[:error] = "Unable to reset API key."
    end
    return redirect_to app_path(@app)
  end
  
  # Primary API endpoint
  # POST /exception
  def exception
    app = App.find_by_api_key(params['api_key'])
    if app.nil?
      return render :json => {:error => "Invalid API key."}
    end
    
    data = params['crash']
    app.register_crash(data)
    
    render :json => {:success => true}
  end
end
