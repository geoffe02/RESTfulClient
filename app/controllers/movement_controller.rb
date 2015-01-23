class MovementController < ApplicationController
  require 'json' # Rails lib for JSON data handling
  require 'net/http' # Rails Lib for web manipulation
  require 'uri' # Helper Lib for net/http
  require 'httparty' # Alternate Lib for web manipulation
  USERNAME = "user" #not used since no authentication
  PASSWORD = "password" #not used since no authentication

  SERVER_BASE_URL = "http://localhost:8080" #Creating a const variable for web location
  #current_status_code = 0
  
  def index
    #parameters setup
    location = "#{SERVER_BASE_URL}/Room3" # Takes us to the teacher's app entrypoint at Room1
    uri = URI.parse(location)
    
    reply = {'name'=>'Geoffe','command' => 'takeSword', 'state' => 11}
    #reply = {'name'=>'Geoffe','command' => 'look','state' =>10}
    reply_headers = {"Content-Type" => "application/json",
       "Accept" => "application/json"}
       
  #  remote = Net::HTTP.new(uri.host, uri.port)
  #  send = remote.post(uri.path, reply.to_json, reply_headers)
  #  payload = response.body
    #payload = send.body
    
    http = Net::HTTP.new(uri.host, uri.port)
    sendrequest = Net::HTTP::Post.new(uri.request_uri, reply_headers)
    sendrequest.body = reply.to_json
    response = http.request(sendrequest)
    
    payload = response.body
    
    
    #response = Net::HTTP.get_response(URI.parse(location)) # Get the entire response from the server.
    #payload = response.body # isolate the specific body that contains the JSON data
    #@result = JSON.parse(payload, :symbolize_names => true) # Save the JSON data and use the parse method to distinguish between key and value of JSON.
    @current_status_code = JSON.parse(payload)['status']
    @message = JSON.parse(payload)['message']    
  end
  
#  def choose
#    @choice = 1
#    if params[:first_button]
      #do stuff for Room2
#      render action: "proceed"
#    elsif params[:second_button]
      #do stuff for Room3
#    elsif params[:third_button]
      #do stuff for Room4
#    end  
    
#  def move
#      location = "#{SERVER_BASE_URL}/Room#{:choice}" # Takes us to the teacher's app next level
#      server_response = Net::HTTP.get_response(URI.parse(location)) # Get the entire response from the server.
#      payload = server_response.body # isolate the specific body that contains the JSON data
 #     @result = JSON.parse(payload, :symbolize_names => true) # Save the JSON data and use the parse method to distinguish between key and value of JSON.
#      @current_status_code = JSON.parse(payload)['status']
#      @message = JSON.parse(payload)['message'] 
#  end  
#  def proceed
#    reply = {'status' => '4'}
#    reply_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
    
#    uri = URI.parse("#{SERVER_BASE_URL}/Room3")
#    nextlocation = "#{SERVER_BASE_URL}/Room3"
#    http = Net::HTTP.new(uri.host, uri.port)
    
#    send = http.post(uri.path, reply.to_json, reply_headers)
    
    # Now Process the data sent back.

#    server_reply = Net::HTTP.get_response(URI.parse(nextlocation)) # Get the entire response from the server.
#    payload = server_reply.body # isolate the specific body that contains the JSON data
#    @reply_result = JSON.parse(payload, :symbolize_names => true) # Save the JSON data and use the parse method to distinguish between key and value of JSON.
#    @next_status_code = JSON.parse(payload)['status']
#    @next_message = JSON.parse(payload)['message']
#  end
  
end

