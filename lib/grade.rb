class Grade
  
  attr_accessor :letter_value, :number_value

  
  def initialize(letter_value)
    raise_exception() unless ('A'..'E').include?(letter_value[0,1].upcase)  #assuming a grade scale from A to E
      
    #set the grade letter value
    self.letter_value = letter_value.upcase 
    
    #get a number value for the grade based upon the char's ascii value
    self.number_value = 10 * (100 - self.letter_value[0])         
    
    #add or subtract from the number value based upon a trailing + or -
    if self.letter_value[1] != nil
      if self.letter_value[1,1] == "+"
        self.number_value += 1
      elsif self.letter_value[1,1] == "-"
        self.number_value -= 1
      else
        #second character is not a + or -, raise exception
        raise_exception()
      end
    end
  end

  def raise_exception()
    raise ArgumentError, 'Argument is not a valid grade value'
  end
  
  #overload each operator to compare the stored number values of each grade
  def ==(grade)
    self.number_value == grade.number_value
  end
  
  def >=(grade)
    self.number_value >= grade.number_value
  end
  
  def <=(grade)
    self.number_value <= grade.number_value
  end
  
  def >(grade)
    self.number_value > grade.number_value
  end
  
  def <(grade)
    self.number_value < grade.number_value
  end
  
  
  #overload the sort operator, but reverse the parameters to get a numerically descending sort
  def <=>(grade)
    grade.number_value <=> self.number_value
  end
  
end
