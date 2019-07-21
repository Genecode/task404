class IncomesController < ApplicationController
  before_action :set_income, only: [:show, :edit, :update, :destroy]
  before_action :set_user, except: %i[destroy]

  def index
    @incomes = @user.incomes
  end

  def show; end

  def new
    @income = @user.incomes.build
  end

  def edit; end

  # POST /incomes
  # POST /incomes.json
  def create
    @income = @user.incomes.build(income_params)

    respond_to do |format|
      if @income.add
        format.html { redirect_to user_income_path(@user, @income), notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: user_income_path(@user, @income) }
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /incomes/1
  # PATCH/PUT /incomes/1.json
  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to user_income_path(@user, @income), notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: user_income_path(@user, @income) }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /incomes/1
  # DELETE /incomes/1.json
  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_income
    @income = Income.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def income_params
    params.require(:income).permit(:amount, :user_id)
  end
end
