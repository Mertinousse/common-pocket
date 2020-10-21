class TransactionsController < ApplicationController
  def index
    @offset = params[:offset].to_i || 0
    @transactions = Transaction.months_before(@offset).includes(:category, :user)
  end

  def create
    Transaction.recur_for(current_user)
    redirect_to transactions_path
  end
end
