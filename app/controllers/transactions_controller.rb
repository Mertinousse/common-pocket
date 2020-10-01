class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def create
  end

  def update
  end

  def destroy
  end
end
