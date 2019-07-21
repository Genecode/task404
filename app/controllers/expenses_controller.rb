class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :set_user, except: %i[destroy]

  def index
    @expenses = @user.expenses
  end

  def show; end

  def new
    @expense = @user.expenses.build
  end

  def edit; end

  def create
    @expense = @user.expenses.build(expense_params)

    respond_to do |format|
      if @expense.add
        format.html { redirect_to user_expense_path(@user, @expense), notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: user_expense_path(@user, @expense) }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to user_expense_path(@user, @expense), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: user_expense_path(@user, @expense) }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def expense_params
    params.require(:expense).permit(:amount, :user_id, :assignment)
  end
end
