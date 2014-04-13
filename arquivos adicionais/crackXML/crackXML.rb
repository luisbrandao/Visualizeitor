gem 'crack' # in Gemfile
require 'crack'

# p = Crack::XML.parse("<tag>This is the contents</tag>")

# puts p

def read_file(file_name)
  file = File.open(file_name, "r")
  data = file.read
  file.close
  return data
end

xml_content = read_file 'alunos.xml'
parsed_xml = Crack::XML.parse(xml_content)
alunos_curso_root = parsed_xml['ALUNOS_CURSO']
alunos = alunos_curso_root['ALUNO']

students = Hash.new

alunos.each do |student| 
   grr_student = student['MATR_ALUNO']
   enrollments = students[grr_student]
   if (enrollments.nil?)
    enrollments = Array.new
    students[grr_student] = enrollments
   end
   enrollments.push(student)
end

puts students['GRR00000010'].first
puts
puts students['GRR00000010'][1]
puts
puts students['GRR00000007'].first
puts
puts students['GRR00000007'][1]



