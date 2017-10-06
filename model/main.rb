require 'csv'

class Main
  def initialize(source)
    @teachers = {}
    fetch_data(source)
  end


  def fetch_data(source)
    CSV.foreach(source) do |row|
      list = Array.new(row)

      begin
        student = list.shift
        list.each do |teacher|
          next if teacher.nil?
          @teachers[teacher] ||= []
          @teachers[teacher].push(student)
        end
      rescue => message
        puts message
        puts '程序終止...'
        exit
      end
    end
  end

  def export(output)
    CSV.open(output, 'wb') do |csv|
      @teachers.each do |teacher, students|
        begin
          row = Array.new(students).unshift(teacher)
          csv << row
        rescue => message
          puts "#{teacher}: #{students.join(',')}"
          puts message
          next
        end
      end
    end
  end

end