class UsersController < ApplicationController
  before_action :authenticate_user!, except: ["welcome"]
  before_action :set_user, only: %w[show update destroy edit]
  after_action :verify_authorized, except: %i[welcome index search reset_password accept_terms]

  # GET /users or /users.json
  def index
    @users = policy_scope(User)
  end

  def welcome; end

  def search
    @users = if current_user.has_role?(:super)
               User.search(params[:query], star: true)
             else
               User.search(params[:query], star: true, with: { company_id: current_user.company_id })
             end

    render "index"
  end

  # GET /users/1 or /users/1.json
  def show
    authorize @user
  end

  # GET /users/new
  def new
    @user = User.new
    @user.company_id = params[:company_id]
    authorize @user
  end

  # GET /users/1/edit
  def edit
    authorize @user
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    authorize @user
    # Ensure we can never update to super
    super_role = Role.where(name: "super").first
    @user.role_ids.delete(super_role.id)

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_company }
        format.json { render json: @user.errors, status: :unprocessable_company }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    authorize @user
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def accept_terms
    current_user.accept_terms = true
    current_user.save
    redirect_to root_path
  end

  # This is used to reset password only for system generated users on the first login
  def reset_password
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    current_user.reset_password_token = hashed
    current_user.reset_password_sent_at = Time.now.utc
    current_user.save

    sign_out current_user

    redirect_to edit_user_password_path(reset_password_token: raw)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, role_ids: [])
  end
end
