class MpdController < ApplicationController
  # Load our ruby-mpd gem environment up
  require 'ruby-mpd'

  # BEFORE and AFTER each action, these methods
  # get called to clean up the code
  before_action :new_mpd, except: [:help]
  after_action :disconnect_mpd, except: [:help]


  # List all available commands for an mpd instance
  def help
    mpd = MPD.new
    # Sort ASC
    @methods = mpd.methods.sort_by{ |method| method }
  end

  # Retrieves information from mpd
  def status

    status            = @mpd.status
    @volume           = status[:volume]
    @repeat           = status[:repeat].humanize
    @random           = status[:random].humanize
    @bitrate          = status[:bitrate]
    @state            = status[:state]
    @opposite_state   = opposite(@state)
    @current_playlist = @mpd.queue.map{ |song| { title: get_title(song), id: song.pos } }

    if !@mpd.current_song
      @current_song = "No song playing"
    else
      #@current_song = @mpd.current_song.title || File.basename(@mpd.current_song.file, File.extname(@mpd.current_song.file)).humanize
      @current_song = get_title(@mpd.current_song)
    end

    @songs = @mpd.songs.map{ |song| get_title(song) }
  end


  # Starts the playlist
  def start
    @mpd.play if @mpd.stopped?
    redirect_to mpd_status_path
  end

  # Stops queue
  def stop
    @mpd.stop unless @mpd.stopped?
    redirect_to mpd_status_path
  end

  # Plays next song
  def next
    @mpd.next
    redirect_to mpd_status_path
  end

  # Plays previous song
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

  # Updates the queue/database
  def update
    @mpd.update
    redirect_to mpd_status_path
  end

  # Performs a search for a specific title and adds
  # the results at the end of our queue
  #
  # How to call this function?:
  # localhost:3000/mpd/add_song?title=TitleToSearchFor
  #
  # Interface(ruby-mpd): 'songs_by_title(title, options = {})'
  def add_song
    if params[:title]
      @mpd.songs_by_title(params[:title], { strict: false, add: true })
    elsif params[:artist]
      @mpd.songs_by_artist(params[:artist], { strict: false, add: true })
    end
    redirect_to mpd_status_path
  end


  # Plays the passed song
  def play_song
    @mpd.play params[:id]
    redirect_to mpd_status_path
  end


  private
  # Creates a new MPD instance
  def new_mpd
    @mpd = MPD.new
    @mpd.connect
  end

  # Closes connection to our instance
  def disconnect_mpd
    @mpd.disconnect
  end

  # Returns the opposite of play/pause
  def opposite(data)
    if data == :play
      "pause"
    else
      :play
    end
  end

  # Retrieves the songs title OR uses its filename in a human readeable form
  def get_title(song)
    song.title || File.basename(song.file, File.extname(song.file)).humanize
  end
end
