#TEST 1 ZENDESK API USAGE
require "zendeskapi"

user_name = "BrandNew User"
user_email = "NewestUser@gmail.com"


#create a new connection as a variable
conn = Connection.new("https://craigrixham.zendesk.com/", "rixhamc@gmail.com", "Rocketman")

#create a new user
conn.new_user(user_name, user_email)

#Create a new ticket with our user as the requester, receive a ticket number
ticket_number = conn.new_ticket("My computer is on fire", user_name, user_email)

#update that ticket number as solved using the ticket number
conn.update_ticket(ticket_number)


#TEST 2 CSS COMPRESSION USAGE
require "CSSCompressor"

#opens a css file
file = CSSCompressor.new("/home/craig/test.css")

#writes the compressed css file
file.compress_to("/home/craig/test2.css")



#TEST 3 GRADING SYSTEM USAGE
require "grade"

#Grades are created as objects
aplus = Grade.new("A")
bminus = Grade.new("B-")
c = Grade.new("C")

#comparison operators can be run on grades
puts aplus > bminus

#grades can be sorted
sorted = [c, aplus, bminus].sort

#letter grades are displayed using their letter_value attribute
sorted.each do |val|
  puts val.letter_value
end


# TEST 4 REFACTORING USAGE

require 'date'
require "Blog"
#Create a new blog as an object, passing the Header and Footer
blog = Blog.new("my blog","Copyright Wobble (2012)")

#A new post can be created with no comments
blog.newpost("No Comments")

#Or one comment
blog.newpost("This is my second post", "This is a single comment")

#or more than one comment
blog.newpost("This post should have multiple comments", "Here's one...", "Here's the second!")

puts blog.render