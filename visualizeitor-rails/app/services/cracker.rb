require 'csv'

module CSVHeaders
  MAJOR_ID = 0
  GRR = 1
  COURSE_VERSION = 2
  STUDENT_NAME = 3
  COURSE_CODE = 4
  COURSE_NAME = 5
  VERSION_NUMBER = 6
  STUDENT_CURRICULUM_ID = 7
  ID_ACTIV_CURRIC = 8
  YEAR = 9
  FINAL_GRADE = 10
  ITEM_SITUATION_ID = 11
  PERIOD = 12
  SITUATION = 13
  ACTIV_CURRIC_CODE = 14
  ACTIV_CURRIC_NAME = 15
  CREDITS = 16
  TOTAL_HOURS = 17
  STRUCTURE_DESCRIPTION = 22
  FREQUENCY = 23
  STATUS = 26
end

class Cracker
  def crack(content_file)
    csv_file = content_file.read
    csv_file = csv_file.force_encoding("utf-8")

    quote_chars = %w(" | ~ ^ & *)
    begin
      csv = CSV.parse(csv_file, {:headers => false, :col_sep => ",", :skip_blanks => true, :quote_char => quote_chars.shift} )
    rescue CSV::MalformedCSVError
      quote_chars.empty? ? raise : retry
    end

    csv.each do |row|
      valid_row = row[0].to_i
      if (valid_row == 0)
        next
      end
      grr = row[CSVHeaders::GRR]
      name = row[CSVHeaders::STUDENT_NAME]
      student = Student.find_by_grr(grr)
      if (student.nil?)
        student = Student.new(name: name, grr: grr)

        major_code = row[CSVHeaders::COURSE_CODE]
        major = Major.find_by_code(major_code)

        if (major.present?)
          student.major = major
        end

        program_code = row[CSVHeaders::COURSE_VERSION]
        program = Program.find_by_code(program_code)
        if (program.present?)
          student.program = program
        end
      end

      student.save!

      course_code = row[CSVHeaders::ACTIV_CURRIC_CODE]
      course_name = row[CSVHeaders::ACTIV_CURRIC_NAME]
      course = Course.find_by_code(course_code)

      if (course.nil?)
        course = Course.create(code: course_code, name: course_name)
      end

      enrollment = Enrollment.new
      enrollment.course = course

      enrollment_type = row[CSVHeaders::STRUCTURE_DESCRIPTION]
      enrollment.enrollment_type = enrollment_type

      enrollment.frequency = row[CSVHeaders::FREQUENCY]

      grade = row[CSVHeaders::FINAL_GRADE].to_i
      if (grade > 100)
        grade = nil
      end
      enrollment.grade = grade
      enrollment.year = row[CSVHeaders::YEAR]

      enrollment.semester = row[CSVHeaders::PERIOD]

      # Fix para tipo de semestre não previsto
      # TODO: Arrumar isso para um semestre diferente para suportar outros cursos
      if (enrollment.semester <= 0)
        enrollment.semester = 1
      end

      enrollment.status = row[CSVHeaders::SITUATION]

      student.enrollments << enrollment

    end
  end
end