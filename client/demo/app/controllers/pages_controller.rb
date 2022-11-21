class PagesController < ApplicationController
  before_action :authenticate_user!
  def home; end

  def update_counter
    current_user.counter += 1
    current_user.save

    # turbo update
    render turbo_stream:
      turbo_stream.replace('counter',
                           partial: 'pages/counter',
                           locals: { counter: current_user.counter })
  end
end
