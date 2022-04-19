class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments or /payments.json
  def index
    @payments = policy_scope(Payment).includes(:phase, :user, project: [:client])
  end

  # GET /payments/1 or /payments/1.json
  def show; end

  # GET /payments/new
  def new
    @payment = Payment.new(payment_params)
    @payment.company_id = current_user.company_id
    @payment.user_id = current_user.id
    if @payment.phase
      @payment.due_date = @payment.phase.end_date + 1.week
      @payment.amount = @payment.phase.due_amount
    end
    authorize @payment
  end

  # GET /payments/1/edit
  def edit; end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.company_id = current_user.company_id
    @payment.user_id = current_user.id
    @payment.amount_cents = payment_params[:amount].to_d * 100

    authorize @payment

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_company }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    @payment.company_id = current_user.company_id
    @payment.user_id = current_user.id
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_company }
        format.json { render json: @payment.errors, status: :unprocessable_company }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
    authorize @payment
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:amount, :plan, :discount, :reference_number, :project_id,
                                    :phase_id, :details, :status,
                                    :due_date, :received_on, attachments: [])
  end
end
