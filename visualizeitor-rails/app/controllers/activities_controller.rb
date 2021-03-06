class ActivitiesController < ApplicationController
  #before_filter :authenticate_student!, exept: [:show]
  before_action :set_activity, only: [:show, :edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
  end

  # GET /activities/new
  def new
    @activity = Activity.new
    5.times{@activity.acdocs.build}
  end

  # GET /activities/1/edit
  def edit
    2.times{@activity.acdocs.build}
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)
    @activity.acform = current_student.acform

    if params[:add_item]
      @activity.acdocs.build
      render :action => 'new'
    else
      respond_to do |format|
        if @activity.save
          format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
          format.json { render action: 'show', status: :created, location: @activity }
        else
          format.html { render action: 'new' }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    if params[:add_item]
      unless params[:activity][:acdocs_attributes].blank?
        for attribute in params[:activity][:acdocs_attributes].permit!
          @activity.acdocs.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      @activity.acdocs.build
      render :action => 'edit'
    else
      respond_to do |format|
        if @activity.update(activity_params)
          format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @activity.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit!
    end
end
