class ProgramItemsController < ApplicationController
  before_action :set_program_item, only: [:show, :edit, :update, :destroy]

  # GET /program_items
  # GET /program_items.json
  def index
    @program_items = ProgramItem.all
  end

  # GET /program_items/1
  # GET /program_items/1.json
  def show
  end

  # GET /program_items/new
  def new
    @program_item = ProgramItem.new
  end

  # GET /program_items/1/edit
  def edit
  end

  # POST /program_items
  # POST /program_items.json
  def create
    @program_item = ProgramItem.new(program_item_params)

    respond_to do |format|
      if @program_item.save
        format.html { redirect_to @program_item, notice: 'Program item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @program_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @program_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /program_items/1
  # PATCH/PUT /program_items/1.json
  def update
    respond_to do |format|
      if @program_item.update(program_item_params)
        format.html { redirect_to @program_item, notice: 'Program item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @program_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /program_items/1
  # DELETE /program_items/1.json
  def destroy
    @program_item.destroy
    respond_to do |format|
      format.html { redirect_to program_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program_item
      @program_item = ProgramItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_item_params
      params.require(:program_item).permit(:row, :column)
    end
end
