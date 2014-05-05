class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:show, :edit, :update, :destroy]

  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all.order(year: :asc).order(semester: :asc)
    if (params[:student_id])
      @student = Student.find(params[:student_id])
      @enrollments = @enrollments.where(student: @student)
    end

    if (params[:course_id])
      @course = Course.find(params[:course_id])
      @enrollments = @enrollments.where(course: @course)

      @approved_number = 0
      @disapproved_grade_number = 0
      @disapproved_frequency_number = 0

      @enrollments.each do |enrollment|
        if (enrollment.status.eql?('Aprovado'))
          @approved_number = @approved_number + 1
        elsif(enrollment.status.eql?('Reprovado por nota'))
          @disapproved_grade_number = @disapproved_grade_number + 1
        elsif(enrollment.status.eql?('Reprovado por Frequência'))
          @disapproved_frequency_number = @disapproved_frequency_number + 1
        end
      end
    end

    @enrollments = @enrollments.paginate(:page => params[:page], :per_page => 20)

  end

  def chart
    if (params[:course_id])
      @course = Course.find(params[:course_id])
    end

    enrollments = @course.enrollments

    json_wrapper = Hash.new
    json_wrapper[:years] = Array.new
    json_wrapper[:approved] = Array.new
    json_wrapper[:disapproved_grade_number] = Array.new
    json_wrapper[:disapproved_frequency_number] = Array.new

    hash_enrollments = Hash.new

    enrollments.each do |enrollment|
      year = enrollment.year
      semester = enrollment.semester
      if hash_enrollments[year].nil?
        hash_enrollments[year] = Hash.new
        hash_enrollments[year][1] = Array.new
        hash_enrollments[year][2] = Array.new
      end
      hash_enrollments[year][semester].push(enrollment)
    end

    hash_enrollments.sort.map do |year, semester|
      semester.sort.map do |number, enrollments|
        puts "semestre: #{number} Matrículas: #{enrollments}"
        json_wrapper[:years].push("#{year}/#{number}")
        approved = 0
        disapproved_grade_number = 0
        disapproved_frequency_number = 0
        enrollments.each do |enrollment|
          if (enrollment.status.eql?('Aprovado'))
            approved = approved + 1
          elsif(enrollment.status.eql?('Reprovado por nota'))
            disapproved_grade_number = disapproved_grade_number + 1
          elsif(enrollment.status.eql?('Reprovado por Frequência'))
            disapproved_frequency_number = disapproved_frequency_number + 1
          end
        end 
        json_wrapper[:approved].push(approved)
        json_wrapper[:disapproved_grade_number].push(disapproved_grade_number)
        json_wrapper[:disapproved_frequency_number].push(disapproved_frequency_number)

      end
    end

    respond_to do |format|
      if (params[:mode] == "1")
        format.json { render json: hash_enrollments }
      else
        format.json { render json: json_wrapper }
      end

      format.html { redirect_to @enrollment, notice: 'Enrollment was successfully created.' }
    end
  end

  def ira_chart
    @enrollments = Enrollment.all.order(year: :asc).order(semester: :asc)

    if (params[:student_id])
      @student = Student.find(params[:student_id])
      @enrollments = @enrollments.where(student: @student)
    end

    json_wrapper = Hash.new
    json_wrapper[:years] = Array.new
    json_wrapper[:grade_average] = Array.new
    json_wrapper[:total_enrollments] = Array.new

    hash_enrollments = create_hash_enrollments(@enrollments)

    hash_enrollments.sort.map do |year, semester|
      semester.sort.map do |number, enrollments|
        json_wrapper[:years].push("#{year}/#{number}")
        grades_sum = 0.0
        valid_enrollments_quantity = 0

        enrollments.each do |enrollment|

          if (enrollment.grade.nil?)
            grade = 0
          else
            grade = enrollment.grade
          end

          if (enrollment.status.eql?('Aprovado'))
            valid_enrollments_quantity = valid_enrollments_quantity + 1
            grades_sum = grades_sum + grade
          elsif(enrollment.status.eql?('Reprovado por nota'))
            valid_enrollments_quantity = valid_enrollments_quantity + 1
            grades_sum = grades_sum + grade
          elsif(enrollment.status.eql?('Reprovado por Frequência'))
            valid_enrollments_quantity = valid_enrollments_quantity + 1
            grades_sum = grades_sum + grade
          end
        end 

        average = 0

        if (valid_enrollments_quantity == 0)
          average = "0.0"
        else
          average = grades_sum/valid_enrollments_quantity
        end

        json_wrapper[:grade_average].push(average)
        json_wrapper[:total_enrollments].push(enrollments.count)

      end
    end

    respond_to do |format|
      format.json { render json: json_wrapper }
      format.html { redirect_to @enrollment, notice: 'Enrollment was successfully created.' }
    end

  end


  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments
  # POST /enrollments.json
  def create
    @enrollment = Enrollment.new(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @enrollment }
      else
        format.html { render action: 'new' }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @enrollment.destroy
    respond_to do |format|
      format.html { redirect_to enrollments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:grade, :frequency, :year, :semester, :status)
    end

    def create_hash_enrollments(enrollments)
      hash_enrollments = Hash.new

      enrollments.each do |enrollment|
        year = enrollment.year
        semester = enrollment.semester
        if hash_enrollments[year].nil?
          hash_enrollments[year] = Hash.new
          hash_enrollments[year][1] = Array.new
          hash_enrollments[year][2] = Array.new
        end
        hash_enrollments[year][semester].push(enrollment)
      end
      hash_enrollments
    end
  end
