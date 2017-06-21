require 'date'

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students = []
  while true do
    name = gets.chomp
      if name.empty?
        break
      end
    puts "What cohort is #{name} in?"
    cohort = gets.chomp.to_sym
    cohort = Date::MONTHNAMES[Date.today.month].to_sym if cohort.empty? #assign current month if no answer given
    puts "Where is #{name} from?"
    cob = gets.chomp
    puts "What is #{name}'s height?"
    height = gets.chomp
    heightnum = height.to_i
      while height.is_a?(Integer) == false && heightnum == 0
        puts "Please enter a valid height"
        height = gets.chomp
        heightnum = height.to_i
      end
    students << {name: name.capitalize, cohort: cohort, country: cob.capitalize, height: height}
    puts "Now we have #{students.count} students. Enter next student"
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "----------"
end

#def print(students)
#  students.each_with_index do |student, index|
#    if (student[:name].downcase.start_with? ("m")) && (student[:name].length > 12)
#      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
#    end
#  end
#end

def print(students)
  index = students.count - 1
  while index >= 0
    puts "#{index + 1}. #{students[index][:name].ljust(20)} (#{students[index][:cohort]} cohort)"
    index = index - 1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students."
end

students = input_students
print_header
print(students)
print_footer(students)
