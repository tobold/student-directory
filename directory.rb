require 'date'
@students = []

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit" # 9 because we'll be adding more items
end

def show_students
  print_header
  print_students
  print_footer
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def input_students
  puts "Please enter the name of the first student"
  puts "To finish, just hit return twice"
  students = []
  while true do
    name = gets.strip
      if name.empty? && students.empty?
        break
      elsif name.empty?
        break
      end
    puts "What cohort is #{name} in? (leaving blank defaults to today's month)"
    cohort = gets.capitalize.strip
    #assign current month if no answer given
    cohort = Date::MONTHNAMES[Date.today.month] if cohort.empty?
      #check that cohort is a valid month.
    while (Date::MONTHNAMES.include? cohort) == false
      puts "Enter a valid month"
      cohort = gets.capitalize.strip
    end
    cohort = cohort.to_sym
    puts "Where is #{name} from?"
    cob = gets.strip
    puts "What is #{name}'s height?"
    height = gets.strip
    heightnum = height.to_i
      while height.is_a?(Integer) == false && heightnum == 0
        puts "Please enter a valid height"
        height = gets.strip
        heightnum = height.to_i
      end
    @students << {name: name.capitalize, cohort: cohort, country: cob.capitalize, height: height}
    if students.count == 1
      puts "Now we have #{@students.count} student. Enter next student"
    else
      puts "Now we have #{@students.count} students. Enter next student"
    end
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "----------"
end

#def print(students)
#  students.each_with_index do |student, index|
#    if (student[:cohort].downcase.start_with? ("m")) && (student[:name].length > 12)
#      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
#    end
#  end
#end

def print_students
  cohortarray = @students.map{|x| x[:cohort]}
  month = 1
  while month <= 12
  index = @students.count - 1
    if cohortarray.include?(Date::MONTHNAMES[month].to_sym)
      puts "Students from the #{Date::MONTHNAMES[month]} cohort:"
    end
    while index >= 0
      if Date::MONTHNAMES[month].to_sym == @students[index][:cohort]
        puts "#{index + 1}. #{@students[index][:name].ljust(20)}"
      end
      index = index - 1
    end
    month = month + 1
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} student."
  else
    puts "Overall, we have #{@students.count} students."
  end
end

interactive_menu
