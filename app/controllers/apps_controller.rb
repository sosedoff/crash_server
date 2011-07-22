class AppsController < ApplicationController
  before_filter :find_app, :except => [:index, :new, :create, :exception, :capistrano]
  before_filter :find_api_by_api_key, :only => [:exception, :capistrano]
  
  def index
    @apps = App.all
  end
  
  def show
    @active_issues = @app.crashes.active
    @closed_issues = @app.crashes.closed
    @deployments   = @app.deployments
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
  
  # Primary API endpoint for exceptions
  # POST /exception
  def exception
    data = params['crash']
    @app.register_crash(data)
    render :json => {:success => true}
  end
  
  # Primary API endpoint for capistrano deployments
  # POST /capistrano
  def capistrano
    p = MultiJson.decode(params[:payload])
    capistrano = p['capistrano']
    
    @app.deployments.create(
      :capistrano_version => capistrano['version'],
      :payload_version    => p['payload_version'],
      :deployer_user      => capistrano['deployer']['user'],
      :deployer_hostname  => capistrano['deployer']['hostname'],
      :source_branch      => capistrano['source']['branch'],
      :source_revision    => capistrano['source']['revision'],
      :source_repository  => capistrano['source']['repository'],
      :action             => capistrano['action'],
      :message            => capistrano['message'],
      :created_at         => capistrano['timestamp']
    )
    
    render :json => {:success => true}
  end
end
