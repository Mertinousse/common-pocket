class WizardReflex < ApplicationReflex
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

  def start
    session[:wizard_step] = 1
    session[:wizard_params] = {}
  end

  def next
    session[:wizard_params].merge!(transaction_params)
    session[:wizard_step] = session[:wizard_step] + 1

    transaction = Transaction.new(session[:wizard_params].merge(user: current_user))

    if transaction.valid?
      transaction.save && reset
    end
  end

  def previous
    if session[:wizard_step] > 1
      session[:wizard_step] = session[:wizard_step] - 1
    else
      reset
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :category_id)
  end

  def reset
    session.delete(:wizard_step)
    session.delete(:wizard_params)
  end
end
