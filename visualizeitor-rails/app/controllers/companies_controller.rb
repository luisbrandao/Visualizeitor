class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.contacts.build
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)
    if params[:add_item]
      @company.contacts.build
      render :action => 'new'
    else
      respond_to do |format|
        if @company.save
          format.html { redirect_to @company, notice: 'Company was successfully created.' }
          format.json { render action: 'show', status: :created, location: @company }
        else
          format.html { render action: 'new' }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    if params[:add_item]
      unless params[:company][:contacts_attributes].blank?
        for attribute in params[:company][:contacts_attributes].permit!
          @company.contacts.build(attribute.last.except(:_destroy)) unless attribute.last.has_key?(:id)
        end
      end
      @company.contacts.build
      render :action => 'edit'
    else
      respond_to do |format|
        if @company.update(company_params)
          format.html { redirect_to @company, notice: 'Company was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @company.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit!
    end
end
