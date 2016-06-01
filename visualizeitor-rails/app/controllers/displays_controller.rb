class DisplaysController < ApplicationController
  before_action :set_display, only: [:show, :edit, :update, :destroy]

  skip_load_and_authorize_resource

  # GET /displays
  # GET /displays.json
  def index
    if student_signed_in?
      @GRR = current_student.grr
    end
  end

end
