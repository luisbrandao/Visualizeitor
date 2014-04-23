class MajorsController < ApplicationController
  before_action :set_major, only: [:show, :edit, :update, :destroy]

  # GET /majors
  # GET /majors.json
  def index
    @majors = Major.all
  end

  # GET /majors/1
  # GET /majors/1.json
  def show
  end

  # GET /majors/new
  def new
    @major = Major.new
  end

  # GET /majors/1/edit
  def edit
  end

  # POST /majors
  # POST /majors.json
  def create
    @major = Major.new(major_params)

    respond_to do |format|
      if @major.save
        format.html { redirect_to @major, notice: 'Major was successfully created.' }
        format.json { render action: 'show', status: :created, location: @major }
      else
        format.html { render action: 'new' }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /majors/1
  # PATCH/PUT /majors/1.json
  def update
    respond_to do |format|
      if @major.update(major_params)
        format.html { redirect_to @major, notice: 'Major was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @major.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /majors/1
  # DELETE /majors/1.json
  def destroy
    @major.destroy
    respond_to do |format|
      format.html { redirect_to majors_url }
      format.json { head :no_content }
    end
  end

  def upload_content
    @major = Major.find(params[:major_id])

    respond_to do |format|
      format.html
    end
  end

  def upload
    @major = Major.find(params[:major_id])
    uploaded_io = params[:program_xml]
    crack_xml(uploaded_io)

    respond_to do |format|
      format.html { redirect_to majors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_major
      @major = Major.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def major_params
      params.require(:major).permit(:name, :code)
    end

    def crack_xml(content_file)
      xml_content = content_file.read
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

      create_students(students) 
    end

    def create_students(students_hash)
      students_hash.each do |grr, enrollments_xml|
        database_student = Student.find_by_grr(grr)
        if (database_student.nil?)
          database_student = Student.new
          database_student.name = enrollments_xml[0]['NOME_ALUNO']
          database_student.grr = grr
        end

        program_code = enrollments_xml[0]['ID_VERSAO_CURSO']

        database_program = Program.find_by_code(program_code)
        if (database_program.nil?)
          puts 'vazio'
        else
          database_student.program = database_program
          fill_enrollments(database_student, enrollments_xml)
        end
        database_student.major = @major

        database_student.save
      end
    end

    def fill_enrollments(database_student, enrollments_xml)
      enrollments_xml.each do |enrollment_xml|
        course_code_xml = enrollment_xml['COD_ATIV_CURRIC']
        course_database = Course.find_by_code(course_code_xml)
        if (course_database.nil?)
          course_name_xml = enrollment_xml['NOME_ATIV_CURRIC']
          course_database = Course.create(code: course_code_xml, name:course_name_xml)
        else

          new_enrollment = Enrollment.new
          new_enrollment.course = course_database
          new_enrollment.enrollment_type = enrollment_xml['DESCR_ESTRUTURA']

          new_enrollment.frequency = enrollment_xml['FREQUENCIA']

          grade = enrollment_xml['MEDIA_FINAL'].to_i
          if (grade > 100)
            grade = nil
          end
          new_enrollment.grade = grade
          new_enrollment.year = enrollment_xml['ANO']
          new_enrollment.semester = enrollment_xml['PERIODO']
          new_enrollment.status = enrollment_xml['SITUACAO']

          database_student.enrollments << new_enrollment
        end
      end 


    end
end
