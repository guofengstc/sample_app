=begin
module Perpetrator
	def crime
	end
end
class TestF
	def crime
	end
end
class Test < TestF
	def initialize
	end
	include Perpetrator
end
puts Test.new.method(:crime).owner
puts Test.new.method(:crime)
puts Test.new.method(:crime).source_location

[1,2,4].each do |a|
	puts a
end

class Navigator
   def initialize
     @page_index = 0
   end
   def next
     @page_index += 1
   end
 end
 navigator = Navigator.new
 puts navigator.next
 puts navigator.next
 puts navigator.instance_eval "@page_index" #=> 2
 puts navigator.instance_eval { @page_index } #=> 2
 Navigator.class_eval do 
 	def hello
 		puts "Hello"
 	end
 end	
 # puts navigator.instance_eval do
 # 	def hello
 # 		puts "Hello"
 # 	end
 # end


    class MyClass  
       @@x = " x"  
       def initialize(s)  
          @mystr = s  
       end  
       def getBinding  
          return binding()  
       end  
    end  
      
    class MyOtherClass  
       @@x = " y"  
       def initialize(s)  
          @mystr = s  
       end  
       def getBinding  
          return binding()   
       end  
    end  
      
    @mystr = self.inspect  
    @@x = " some other value"  
    ob1 = MyClass.new("ob1 string")  
    ob2 = MyClass.new("ob2 string")  
    ob3 = MyOtherClass.new("ob3 string")  
    # puts(eval("@mystr << @@x", ob1.getBinding))  #=> ob1 string x  
    # puts(eval("@mystr << @@x", ob2.getBinding))  #=> ob2 string x  
    # puts(eval("@mystr << @@x", ob3.getBinding))  #=> ob3 string y  
    # puts(eval("@mystr << @@x", binding))             #=> main some other value  

    class MyModule
    	@@x = 'MyModule X'
    	VB = 'vb'
    end
    puts MyModule.public_constant

    def a(a)
    	a<<"a"
    end

    def b(b)
    	b<<"b"
    end

    def c(c)
    	c<<"c"
    end

    str="1"
    puts(b a  c str)

    class Calculator
       class << self
         def evaluate(&script)
           self.new.instance_eval(&script)
         end
       end

       def multiply(arg)
         eval arg
       end

       def two(arg=nil)
         "2#{arg}"
       end

       def times(arg)
         " * #{arg}"
       end
     end


    puts Calculator.evaluate { multiply two times two }
=end
    # module Base

    #   #扩展类方法
    #   def self.included(base)
    #     def base.call
    #       puts "I'm strong!"
    #     end
    #     base.extend(ClassMethods)
    #   end

    #   #类方法
    #   module ClassMethods
    #     def hello
    #       puts "Hello baby!"
    #     end
    #   end
       
    # end

    # class Bus
    #   include Base
    # end

    # # Bus.new.show
    # Bus.hello

    module BC
      def self.included(base) 
        puts "123"
        def base.call  
          puts "I'm strong!"  
        end
        base.extend(ClassMethods)
      end
      module ClassMethods
           def hello
             puts "Hello baby!"
           end
      end
   end

   class Bus
		def self.included(base) 
			puts "123"
		  def base.call  
		    puts "I'm strong!"  
		  end
		  base.extend(ClassMethods)
		end
    # include BC
   end
   # puts Bus.included("a")
   # Bus.new.hello
   Bus.hello

