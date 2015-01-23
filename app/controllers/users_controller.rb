class UsersController < ApplicationController
  #respond_to :json
  require 'json' # Rails lib for JSON data handling
  require 'net/http' # Rails Lib for web manipulation
  require 'uri' # Helper Lib for net/http
  require 'httparty' # Alternate Lib for web manipulation
  USERNAME = "user" #not used since no authentication
  PASSWORD = "password" #not used since no authentication

  SERVER_BASE_URL = "http://localhost:8080" #Creating a const variable for web location
  #current_status_code = 0
  
  def show
    location = "#{SERVER_BASE_URL}/Room1" # Takes us to the teacher's app entrypoint at Room1
    server_response = Net::HTTP.get_response(URI.parse(location)) # Get the entire response from the server.
    payload = server_response.body # isolate the specific body that contains the JSON data
    @result = JSON.parse(payload, :symbolize_names => true) # Save the JSON data and use the parse method to distinguish between key and value of JSON.
    @current_status_code = JSON.parse(payload)['status']
    @message = JSON.parse(payload)['message']
    
  end
  
  def choose
    @choice = 1
    if params[:first_button]
      #do stuff for Room2
      render action: "proceed"
    elsif params[:second_button]
      #do stuff for Room3
    elsif params[:third_button]
      #do stuff for Room4
    end  
    
  def move
      location = "#{SERVER_BASE_URL}/Room#{:choice}" # Takes us to the teacher's app next level
      server_response = Net::HTTP.get_response(URI.parse(location)) # Get the entire response from the server.
      payload = server_response.body # isolate the specific body that contains the JSON data
      @result = JSON.parse(payload, :symbolize_names => true) # Save the JSON data and use the parse method to distinguish between key and value of JSON.
      @current_status_code = JSON.parse(payload)['status']
      @message = JSON.parse(payload)['message'] 
  end  
  def proceed
    reply = {'name' => 'Geoffe', 'status' => '0', 'command' => 'look'}
    reply_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
    
    uri = URI.parse("#{SERVER_BASE_URL}/Room2")
    nextlocation = "#{SERVER_BASE_URL}/Room2"
    http = Net::HTTP.new(uri.host, uri.port)
    
    send = http.post(uri.path, reply.to_json, reply_headers)
    
    # Now Process the data sent back.
    #nextlocation = "#{SERVER_BASE_URL}/Room2"
    server_reply = Net::HTTP.get_response(URI.parse(nextlocation)) # Get the entire response from the server.
    payload = server_reply.body # isolate the specific body that contains the JSON data
    @reply_result = JSON.parse(payload, :symbolize_names => true) # Save the JSON data and use the parse method to distinguish between key and value of JSON.
    @next_status_code = JSON.parse(payload)['status']
    @next_message = JSON.parse(payload)['message']
  end
end
  #def siopao
  #  location = "#{SERVER_BASE_URL}/Room1"
  #  @server_response = HTTParty.get(location)
  # @result = JSON.parse(@server_response.body)  
  #end
end

