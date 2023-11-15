class MembershipsController < ApplicationController
  before_action :set_membership, only: %i[show edit update destroy]

  # GET /memberships or /memberships.json
  def index
    @memberships = Membership.all
  end

  # GET /memberships/1 or /memberships/1.json
  def show
  end

  # GET /memberships/new
  def new
    @membership = Membership.new
    @beer_clubs_t = BeerClub.all
    @beer_clubs = []
    @beer_clubs_t.each do |club|
      if club.members.exclude?(current_user)
        @beer_clubs.append(club)
      end
    end
  end

  # GET /memberships/1/edit
  def edit
  end

  # POST /memberships or /memberships.json
  # def create
  #   @membership = Membership.new(membership_params)

  #   respond_to do |format|
  #     if @membership.save
  #       format.html { redirect_to membership_url(@membership), notice: "Membership was successfully created." }
  #       format.json { render :show, status: :created, location: @membership }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @membership.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def create
    @membership = Membership.create params.require(:membership).permit(:beer_club_id)
    @membership.user = current_user
    if @membership.save()
      redirect_to beer_club_url(:beer_club_id), notice: "#{current_user.username} welcome to the club!" 

    else
      @beer_clubs = BeerClub.all
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /memberships/1 or /memberships/1.json
  def update
    respond_to do |format|
      if @membership.update(membership_params)
        format.html { redirect_to membership_url(@membership), notice: "Membership was successfully updated." }
        format.json { render :show, status: :ok, location: @membership }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1 or /memberships/1.json
  def destroy
    name = @membership.beer_club.name
    @membership.destroy

    respond_to do |format|
      #@beer_club = BeerClub.find(params[:beer_club_id])
      format.html { redirect_to beer_club_url(:beer_club_id), notice: "Membership in #{name} ended." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_membership
    @membership = Membership.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def membership_params
    # params.require(:membership).permit(:user_id, :beer_club_id)
    # @membership.user = current_user
    params.require(:membership).permit(:user_id, :beer_club_id, :membership_id, :beer_club_name)
  end
end
