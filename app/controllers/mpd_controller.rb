class MpdController < ApplicationController
  require 'ruby-mpd'

  # BEFORE and AFTER each action, these methods
  # get called to clean up the code
  before_action :new_mpd, except: [:help]
  after_action :disconnect_mpd, except: [:help]

  # List all available commands for an MPD instance
  def help
    mpd = MPD.new
    # Sort ASC
    @methods = mpd.methods.sort_by{ |method| method }
  end

  # Show information on our status page
  def status

    status            = @mpd.status
    @volume           = status[:volume]
    @repeat           = status[:repeat].humanize
    @random           = status[:random].humanize
    @bitrate          = status[:bitrate]
    @state            = status[:state]
    @opposite_state   = opposite(@state)
    @current_playlist = @mpd.queue.map{ |song| get_title(song) }

    if !@mpd.current_song
      @current_song = "No song playing"
    else
      #@current_song = @mpd.current_song.title || File.basename(@mpd.current_song.file, File.extname(@mpd.current_song.file)).humanize
      @current_song = get_title(@mpd.current_song)
    end

    @songs = @mpd.songs.map{ |song| get_title(song) }
  end


  # Start the playlist
  def start
    @mpd.play if @mpd.stopped?
    redirect_to mpd_status_path
  end

  def stop
    @mpd.stop unless @mpd.stopped?
    redirect_to mpd_status_path
  end

  def next
    @mpd.next
    redirect_to mpd_status_path
  end

  def previous
    @mpd.previous
    redirect_to mpd_status_path
  end

  # Toggles the current song (play/pause)
  def pause
    @mpd.pause= unless @mpd.paused?
                end

    redirect_to mpd_status_path
  end

  def update
    @mpd.update
    redirect_to mpd_status_path
  end


  private
  # Create new MPD instance
  def new_mpd
    @mpd = MPD.new
    @mpd.connect
  end

  # Close connection to our instance
  def disconnect_mpd
    @mpd.disconnect
  end

  def opposite(data)
    if data == :play
      "pause"
    else
      :play
    end
  end

  def get_title(song)
    song.title || File.basename(song.file, File.extname(song.file)).humanize
  end
end
