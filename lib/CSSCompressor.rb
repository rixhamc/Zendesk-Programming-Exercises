class CSSCompressor
  
  attr_accessor :filepath
  
  #conditions to test for:
  #if file exists
  #if it can be opened?
  
  def initialize(filepath)

    @cssfile = nil
    
    #Check to see if the file exists and is accessible
    if File.exists?(filepath) and File.readable?(filepath)
      @cssfile = File.new(filepath, "r")  #open the file
    end
    
  end
  
  #conditions to test for:
  #if the new file can be written
  #if the old file is blank

  def compress_to(newfilepath)
    @newfile = File.open(newfilepath, "w")
    if @cssfile == nil  #if the input file didn't exist or couldn't be opened, print an error in the new file
      @newfile.puts("ERROR: No input file has been used.  Either the specified input file does not exist, or it cannot be read")
    end
      
      
      @cssfile.each do |line|                         #get each line of the file
        temp_line = line.strip() + "\n"               #strip whitespace and store in a temp variable
        case temp_line[0,1]                           #switch statement for first char of line
        when "\n"                                     #when the line is blank, do nothing
        when "/"                                      #when the first char is a slash
          unless temp_line[1,1] == "*"                #check for a comment marker
            @newfile.puts(line)                       #if there is no comment, print the line
          end
        else
          @newfile.puts(line)                         #print the line
        end
      end          
    end
  end
