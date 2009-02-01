class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invitation }
    end
  end

  def create
    @invitation = Invitation.new(params[:invitation])
    respond_to do |format|
      if @invitation.save
        flash[:notice] = 'Invitation was successfully created.'
        format.html { redirect_to(@invitation) }
        format.xml  { render :xml => @invitation, :status => :created, :location => @invitation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invitation.errors, :status => :unprocessable_entity }
      end
    end
  end

end