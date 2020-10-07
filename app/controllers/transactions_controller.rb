class TransactionsController < ApplicationController
  def index
    @offset = params[:offset].to_i || 0
    @transactions = Transaction.months_before(@offset).includes(:category, :user)
  end

  def create
  end

  def update
  end

  def destroy
  end
end
