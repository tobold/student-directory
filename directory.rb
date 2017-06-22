require 'date'
@students = []

def pushtostudents(name, cohort, cob, height)
  @students << {name: name, cohort: cohort.to_sym, cob: cob, height: height}
end

def save_students(filename)
  if filename.to_s.empty?
    puts "Enter filename"
    filename = STDIN.gets.chomp
    #recursion!
    save_students(filename)
  else
    File.open(filename, "w") do |data|
      @students.each do |student|
        student_data = [student[:name], student[:cohort], student[:cob], student[:height]].join(",")
        data.puts student_data
      end
    end
    puts "Student list saved as #{filename}"
  end
end

def load_students(filename)
  if filename.to_s.empty?
    #set default filename
    filename = "students.csv"
    #recursion!
    load_students(filename)
  elsif File.exists?(filename)
    File.open(filename, "r").readlines.each do |line|
      name, cohort, cob, height = line.chomp.split(',')
      pushtostudents(name, cohort, cob, height)
    end
    puts "Loaded students from #{filename}. There are currently #{@students.count} students."
  else
    puts "Sorry, #{filename} doesn't exist."
    return
  end
end

def try_load_students
  filename = ARGV.first
  load_students(filename)
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    puts "Enter filename"
    filename = STDIN.gets.chomp
    save_students(filename)
  when "4"
    puts "Enter filename (blank loads default)"
    filename = STDIN.gets.chomp
    load_students(filename)
  when "5"
    @students.clear
    puts "Database cleared"
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load a list"
  puts "5. Clear list"
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
    process(STDIN.gets.chomp)
  end
end

def input_students
  puts "Please enter the name of the first student"
  puts "To finish, just hit return twice"
  while true do
    name = STDIN.gets.split.map(&:capitalize).join(' ').strip
      if name.empty?
        break
      end
    puts "What cohort is #{name} in? (leaving blank defaults to today's month)"
    cohort = STDIN.gets.capitalize.strip
    #assign current month if no answer given
    cohort = Date::MONTHNAMES[Date.today.month] if cohort.empty?
      #check that cohort is a valid month.
    while (Date::MONTHNAMES.include? cohort) == false
      puts "Enter a valid month"
      cohort = STDIN.gets.capitalize.strip
    end
    puts "Where is #{name} from?"
    cob = STDIN.gets.capitalize.strip
    puts "What is #{name}'s height?"
    height = STDIN.gets.strip
    heightnum = height.to_i
      while height.is_a?(Integer) == false && heightnum == 0
        puts "Please enter a valid height"
        height = STDIN.gets.strip
        heightnum = height.to_i
      end
    pushtostudents(name, cohort, cob, height)
    if @students.count == 1
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

try_load_students
interactive_menu
