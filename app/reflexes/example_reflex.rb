class ExampleReflex < ApplicationReflex
  delegate :current_user, to: :connection

  # Add Reflex methods in this file.
  #
  # All Reflex instances expose the following properties:
  #
  #   - connection - the ActionCable connection
  #   - channel - the ActionCable channel
  #   - request - an ActionDispatch::Request proxy for the socket connection
  #   - session - the ActionDispatch::Session store for the current visitor
  #   - url - the URL of the page that triggered the reflex
  #   - element - a Hash like object that represents the HTML element that triggered the reflex
  #   - params - parameters from the element's closest form (if any)
  #
  # Example:
  #
  #   def example(argument=true)
  #     # Your logic here...
  #     # Any declared instance variables will be made available to the Rails controller and view.
  #   end
  #
  # Learn more at: https://docs.stimulusreflex.com

  def new
    session[:step] ||= 0
    session[:transaction_params] ||= {}

    if (1..2).cover? session[:step]
      session[:transaction_params].merge!(transaction_params)
    end

    session[:step] = session[:step] + 1

    if session[:transaction_params]['category_id'].present?
      Transaction.create(session[:transaction_params].merge(user: current_user))
      hide_form
    end
  end

  def cancel
    hide_form
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :category_id)
  end

  def hide_form
    session.delete(:step)
    session.delete(:transaction_params)
  end
end
