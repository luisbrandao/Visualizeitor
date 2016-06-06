class AcformsController < ApplicationController
  before_filter :authenticate_student!, exept: [:show]
  before_action :set_acform, only: [:show, :edit, :update, :destroy]

  # GET /acforms
  # GET /acforms.json
  def index
    if student_signed_in?
      if current_student.acform.blank?
        @acform = Acform.new
        @acform.student_id = current_student.id
        @acform.save!
      else
        @acform = current_student.acform
        render :action => 'show'
      end
    end
    # DeadCode?
    @acforms = Acform.all
  end

  # GET /acforms/1
  # GET /acforms/1.json
  def show
  end

  # GET /acforms/new
  def new
    @acform = Acform.new
  end

  # GET /acforms/1/edit
  def edit
  end

  # POST /acforms
  # POST /acforms.json
  def create
    @acform = Acform.new(acform_params)

    respond_to do |format|
      if @acform.save
        format.html { redirect_to @acform, notice: 'Acform was successfully created.' }
        format.json { render action: 'show', status: :created, location: @acform }
      else
        format.html { render action: 'new' }
        format.json { render json: @acform.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acforms/1
  # PATCH/PUT /acforms/1.json
  def update
    respond_to do |format|
      if @acform.update(acform_params)
        format.html { redirect_to @acform, notice: 'Acform was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @acform.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acforms/1
  # DELETE /acforms/1.json
  def destroy
    @acform.destroy
    respond_to do |format|
      format.html { redirect_to acforms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acform
      @acform = Acform.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def acform_params
      params.require(:acform).permit(:state, :student_id)
    end
end
