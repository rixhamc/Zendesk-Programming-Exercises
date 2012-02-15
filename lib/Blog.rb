class Blog < Object
  attr_accessor :header, :footer
  def initialize(header, footer)
    @header = header
    @footer = footer
    @posts = []                                             #set the blog's posts as empty array
  end
  
  class Post
    attr_accessor :title, :comments
    def initialize (title, *comments)
      @title = title
      @comments = *comments                                 #receive comments as an array, if there is more than one
      @created_at = Time.now
    end   
  end

  def newpost(title, *comments)
    p = Post.new(title, *comments)
    @posts << p                                             #when a post is created, add it to the blog's array
  end
  
  def htmltag(tag, content)
    return ['<',tag,'>',content,'</',tag,'>'].join()        #allow function to use any tag
  end


  def render
    output = [htmltag("div", htmltag("h1", @header))]
    @posts.each do |p|                                            #For each post
      output << htmltag("div", htmltag("p", p.title.upcase))      #Output the title 
      unless p.comments == nil
        p.comments.each do |c|                                      #Output any comments
          output << htmltag("div",c)
        end
      end
    end
    output << (htmltag("div", @footer))                           #Add the footer
  end

end

