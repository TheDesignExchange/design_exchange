# == Description
#
# Controller for the (mostly) static pages of the site.

class MainPagesController < ApplicationController
  # The DesignExchange home page.
  #
  # If viewed without logging in, should display some information about the site and direct the
  # user to sign-up or search for methods.
  #
  # If logged in, should show activity feed (to be developed), any update information (to be
  # determined), and navigation for basic tasks.
  def home
  end

  # Show information about the project itself
  def about
  end

  # Show contact information about the project members
  def contact
  end
end
