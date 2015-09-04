class Supervisor::BaseController < ApplicationController

  before_action :must_be_supervisor
  helper_method :supervised_teams

  protected

  def must_be_supervisor
    unless signed_in? && current_user.roles.includes?('supervisor')
      redirect_to root_path, alert: 'Sorry, dashboard is for supervisors only'
    end
  end

  def supervised_teams
    @supervised_teams = current_user.teams.select { |t| t.supervisors.where(name: current_user.name).count > 0 }
  end

end
