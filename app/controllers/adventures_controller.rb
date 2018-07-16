class AdventuresController < ApplicationController
  def index
    duration = (params[:duration] || 3000).to_i

    thread = Thread.new do
      DHC::StopService.new.run
      DHC::AdventureService.new.run
      DHC::ReplayService.new(duration).run
      DHC::QuitAppService.new.run
    end
    thread[:group] = "dhc"

    render json: { task: "starting adventures(#{duration})..." }
  end
end
