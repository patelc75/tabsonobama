class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      flash[:notice] = 'Invitation sent.'
      redirect_back_or_default(root_url)
    else
      render :action => "new"
    end
  end

end