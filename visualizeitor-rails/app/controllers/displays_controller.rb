class DisplaysController < ApplicationController
  before_action :set_display, only: [:show, :edit, :update, :destroy]

  # GET /displays
  # GET /displays.json
  def index
  end

end
