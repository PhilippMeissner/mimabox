class MpdController < ApplicationController
  require 'ruby-mpd'

  # List all available commands for an MPD instance
  def help
    mpd = MPD.new
    # Sort ASC
    @methods = mpd.methods.sort_by{|m| m}
  end

end
