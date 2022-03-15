class MicrogridController < ApplicationController

  before_action :set_microgrid, only: %i[ show ]

  def index
    @grids = Microgrid.all
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def create
  end

  def update
  end

  def new
  end

  private

  def set_microgrid
    @microgrid = Microgrid.find(params[:id])
  end

  def microgrid_params
    params.require(:microgrid).permit(:name, :total_load, :total_input, :frequency)
  end

end
