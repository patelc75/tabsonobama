class CabinetMembersController < ApplicationController
	def index
		@cabinet_members = CabinetMember.find(:all)
	end
	def list
		@cabinet_members = CabinetMember.find(:all)
	end
	def show
		@cabinet_member = CabinetMember.find(params[:id])
	end
end
