module UsersHelper
  def getValue(value)

   # validate integer
   if value.is_a? Integer

     # is integer > lets format
     if value > 0
       value.to_f / 100.to_f
     else
       "0.00"
     end

   # its not integer > already formated
   else
     value
   end


 end
end
