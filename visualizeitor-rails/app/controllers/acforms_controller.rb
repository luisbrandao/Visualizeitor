class AcformsController < ApplicationController
  before_filter :authenticate_student!
  before_action :set_acform, only: [:show, :edit, :update, :destroy, :submit]

  # GET /acforms
  # GET /acforms.json
  def index
    if student_signed_in?
      if current_student.acform.blank?
        @acform = Acform.new
        @acform.state = 1
        @acform.student_id = current_student.id
        @acform.save!
      end

      @activities = current_student.acform.activities
      @acform = current_student.acform
      render :action => 'alpage'
    end
    # DeadCode?
    @acforms = Acform.all
  end

  # GET /acforms/1
  # GET /acforms/1.json
  def show
    @activities = current_student.acform.activities
      if student_signed_in?
        render :action => 'alpage'
      end
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

  def submit
    respond_to do |format|
      if @acform.complete?
        if @acform.submit!
          flash[:success] = 'O formulário foi submetido para avaliação com sucesso!'
          format.html { redirect_to @acform }
          format.json { head :no_content }
        else
          flash[:danger] = 'Não foi possivel atualizar o estado do formulário'
          format.html { redirect_to @acform }
          format.json { head :no_content }
        end
      else
          flash[:danger] = 'Seu formulário não está apto a ser submetido para avaliação'
          format.html { redirect_to @acform }
          format.json { head :no_content }
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
