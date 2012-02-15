
require "rubygems"
require "faraday"   #REST
require "builder"   #XML builder

class Connection

  #handle a new connection as an object
  def initialize(url, email, password)
    @connection = Faraday.new(:url => url) 
    @connection.basic_auth(email, password)
    @connection.headers['Content-Type']='application/xml'
  end

  
  def new_user(name, email)
     #editing users.xml
    @connection.post '/users.xml', 
      (
        #construct the xml request that provides a new name and email
        xml = Builder::XmlMarkup.new( :indent => 2 )
        xml.instruct! :xml, :encoding => "UTF-8"
        xml.user do |o|
          o.email email
          o.name name
        end
      )

  end
  
  #method for creating a new ticket
  #this method returns the ticket number of the ticket that was created
  def new_ticket(description, requester_name, requester_email)
    
    result = @connection.post "/tickets.xml", 
      (
        #construct xml request to create a new ticket
        xml = Builder::XmlMarkup.new( :indent => 2 )
        xml.instruct! :xml, :encoding => "UTF-8"
        xml.ticket do |t|
          t.tag! "description" , description
          t.tag! "requester-name", requester_name
          t.tag! "requester-email", requester_email
        end
      )
      #need the ticket number of the ticket we just created, located in the Location field 
      #of the response to our request
    str = String(result.headers)    #format the response as a String
    str_array = str.split(";")      #split the string by ;, as the number is in the first section
    return str_array[0].delete("^0-9")  #remove everything but numbers from the first section, leaving the ticket number
  end

  #this method marks a given ticket as having a status of "3", or "solved"
  def update_ticket(ticket_num)
    
    url = ['/tickets/',ticket_num,'.xml'].join
    result = @connection.put url, 
      (
        xml = Builder::XmlMarkup.new( :indent => 2 )
        xml.instruct! :xml, :encoding => "UTF-8"
        xml.ticket do |t|
          t.tag! "solved-at", Time.now
          t.tag! "status-id", "3"
        end
      )
  end

end