class InstrumentController < ApplicationController
  helper :work, :edition
  def show
    @instrument = Instrument.find(params[:id])
  end
end
