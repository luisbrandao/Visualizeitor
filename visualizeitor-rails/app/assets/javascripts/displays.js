var studentJson;
var programJson;

jQuery(document).ready(function($) {
  registerCallbacks();


});

function registerCallbacks()
{
	$(document).on('click', '#buttonSearchGRR', function(event) {
    event.preventDefault();
    didClickButtonSearchGRR();
  });
  $(".gridContent").click(function (){
    gridContentClick(this.id);
  });
  $("[data-isopt = 'true']").click(function (){
    optClick(this.id);
  });
  $(".gridContent").mouseenter(function (){
    gridContentMouseover(this.id);
  });
  $(".gridContent").mouseleave(function (){
    gridContentLeave(this.id);
  });


}

function didClickButtonSearchGRR()
{
  var enteredGRR = $('#GRR').val();

  $.ajax({
      url: '/students/search.json',
      type: 'GET',
      data: {GRR: enteredGRR},
      success: function (data) {
        studentJson = data;
        didDownloadStudent(data);        
      }
    });

};

function didDownloadStudent(student)
{
  var stringified = JSON.stringify(student, null, 2);  
  $('#student-result').html(stringified);

  downloadStudentProgram(student);
}

function downloadStudentProgram(student)
{
    $.ajax({
      url: '/programs/'+ student.program_id + '.json',
      type: 'GET',
      success: function (data) {
        programJson = data;
        didDownloadProgram(data);        
      }
    });
};

function didDownloadProgram(program)
{
  var stringified = JSON.stringify(program, null, 2);  
  $('#program-result').html(stringified);
  drawGrid();
}

function drawGrid(){

  var text = "";
  var program_items = programJson.program_items;
  var gridContainer = document.getElementById('gridContainer');
  var optCount = 0;
  var colCount = 0;
  var rowCount = 0;

  gridContainer.innerHTML = "";

  for (i in program_items) {
    if(program_items[i].column > colCount)
      var colCount = program_items[i].column;
    if(program_items[i].row > rowCount)
      var rowCount = program_items[i].row;
  }

  for (colId = 0; colId <= colCount; colId++){
    text = '<div class="gridCol" id="gridCol-'+ colId + '">'
    + '<div class="gridCell gridColTitle">'+ parseInt(colId+1) +'</div>'
    + '</div>';
    gridContainer.innerHTML += text;
    selectedCol = document.getElementById("gridCol-"+colId);
    for (rowId = 0; rowId <= rowCount; rowId++){
      text ='<div class="gridCell" id="gridCell-'+rowId+'-'+colId+'"></div>';
      selectedCol.innerHTML += text;
    }

  }

  for (i in program_items) {

    colId = program_items[i].column;
    rowId = program_items[i].row;
    courseId = program_items[i].course_id;
    courseName = program_items[i].course.name;
    courseCode = program_items[i].course.code;

    selectedCell = document.getElementById('gridCell-'+rowId+'-'+colId);

    //optativa
    if(courseId == 34){ 
      text =  '<div class="gridContent statusDefault"  id=gridContent-' + courseId + '-opt'+optCount+' data-isopt="true"  data-assigned = "false">'
      + '<div class="gridCourseCode">'+ courseCode +'</div>'
      + '<div class="gridCourseName">'+ courseName +'</div>'
      + '</div>';

      optCount++;
    }
    else {
      text =  '<div class="gridContent statusDefault"  id=gridContent-' + courseId + ' data-assigned = "false">'
      + '<div class="gridCourseCode">'+ courseCode +'</div>'
      + '<div class="gridCourseName">'+ courseName +'</div>'
      + '</div>';
    }

    selectedCell.innerHTML += text;
  }

  cellWidth = 100/(colCount+1) - 0.5;

  cellWidth = cellWidth+"%"
  $('.gridCol').css({"width": cellWidth });

  setGridStatus(studentJson);
  registerCallbacks();
}


function setGridStatus(studentJson){

  enrollments = studentJson.enrollments;
  optCount = 0;

  document.getElementById('studentName').innerHTML = studentJson.name;
  document.getElementById('studentGrr').innerHTML = studentJson.grr;
  document.getElementById('programName').innerHTML = programJson.name;

  for (i in enrollments){
    status = enrollments[i].status;
    courseId = enrollments[i].course_id;
    enrollmentId = enrollments[i].id;
    semester = enrollments[i].semester;
    year = enrollments[i].year;
    grade = enrollments[i].grade;
    frequency = enrollments[i].frequency;
    courseId = enrollments[i].course_id;

    if (document.getElementById('gridContent-'+courseId) != null){
      selectedId = 'gridContent-'+courseId;
    }
    else { // optativa
/*      if((status == 'Dispensa de Disciplinas (com nota)') ||
        (status == 'Aprovado') ||
        (status == 'Matrícula') ||
        (status == 'Equivalência de Disciplina'))
{*/
      text =  '<div class="gridCourseCode">'+ enrollments[i].course.code+' (OPT) </div>'
      + '<div class="gridCourseName">'+ enrollments[i].course.name +'</div>';



      if ($("[data-course_id = "+"'"+courseId+"'"+"]").length == 0){
        document.getElementById('gridContent-34-opt'+optCount).innerHTML = text;
        selectedId = 'gridContent-34-opt'+optCount;
        optCount++;
      }
      else { 
        selectedId = $("[data-course_id = "+"'"+courseId+"'"+"]").attr('id');
      }

    }

    $('#'+selectedId).attr('class', 'gridContent '+getStatusClass(status));
    $('#'+selectedId).attr('data-assigned', "true");
    $('#'+selectedId).attr('data-status', status);
    $('#'+selectedId).attr('data-enrollment_id', enrollmentId);
    $('#'+selectedId).attr('data-semester', semester);
    $('#'+selectedId).attr('data-year', year);
    $('#'+selectedId).attr('data-frequency', frequency);  
    $('#'+selectedId).attr('data-grade', grade);
    $('#'+selectedId).attr('data-course_id', courseId);
  }   
}



function getStatusClass(status){

  switch(status){
    case 'Reprovado por Frequência':
    return 'statusFailed';
    break;
    case 'Reprovado por nota':
    return 'statusFailed2';
    break;
    case 'Dispensa de Disciplinas (com nota)':
    return 'statusExempt';
    break;
    case 'Aprovado':
    return 'statusApproved';
    break;
    case 'Cancelado':
    return 'statusCanceled';
    break;
    case 'Trancamento Total':
    return 'statusSuspended';
    break;
    case 'Matrícula':
    return 'statusEnrolled';
    break;
    case 'Equivalência de Disciplina':
    return 'statusApproved';
    break;
  }
}

function gridContentClick(contentId){
  updateCourseInfo(contentId)
}

function updateCourseInfo (contentId){
  var enrollments = [];

  $('#courseOptInfo').css({"display": "none" })

  courseId = $('#'+contentId).attr('data-course_id');

  $("[data-selected = 'true']").attr('data-selected', 'false');

  if ($('#gridContent-'+courseId).attr("data-assigned")=="true"){
    $('#'+contentId).attr('data-selected', "true"); 
    $('#courseInfo').css({"display": "block" });

    for(i in studentJson.enrollments){
      if (studentJson.enrollments[i].course_id == courseId){
        enrollments.push(studentJson.enrollments[i]);
      }
    }
    document.getElementById('infoCourseName').innerHTML = enrollments[enrollments.length-1].course.code + ' - ' + enrollments[enrollments.length-1].course.name;
    document.getElementById('lastSemester').innerHTML = enrollments[enrollments.length-1].year +' / '+enrollments[enrollments.length-1].semester;
    document.getElementById('lastGrade').innerHTML = enrollments[enrollments.length-1].grade;
    document.getElementById('lastFreq').innerHTML = enrollments[enrollments.length-1].frequency;
    document.getElementById('lastStatus').innerHTML = enrollments[enrollments.length-1].status;

    $('#infoTableRow').attr('class', 'infoTableRow '+getStatusClass(enrollments[enrollments.length-1].status));
  }
  else
    $('#courseInfo').css({"display": "none" });


  if (enrollments.length > 1){
    $('#courseOldInfo').css({"display": "block" })  

    text = '<tr class="infoTableTitle"><td id="infoCourseName"> </td></tr> <tr class="infoTableTitle"><td>Período</td><td>Nota</td><td>Frequência</td><td>Situação</td></tr>';
    for (var i = enrollments.length - 2; i >= 0; i--) {
      text += '<tr class="infoTableRow '+ getStatusClass(enrollments[i].status) +'">'+
      '<td>'+ enrollments[i].year +' / '+enrollments[i].semester +'</td>' +
      '<td>'+ enrollments[i].grade +'</td>' +
      '<td>'+ enrollments[i].frequency +'</td>' +
      '<td>'+ enrollments[i].status +'</td>' +
      '</tr>';
    }
    document.getElementById('oldInfoTable').innerHTML = text;
  }

  else $('#courseOldInfo').css({"display": "none" });

}


function optClick(contentId){
  $('#courseOldInfo').css({"display": "none" });
  $('#courseInfo').css({"display": "none" });
  $('#courseOptInfo').css({"display": "block" });

  var enrollments = [];
  $("[data-selected = 'true']").attr('data-selected', 'false');
  $('#'+contentId).attr('data-selected', "true"); 

  for(i in studentJson.enrollments){


    if ( ($("[data-course_id = "+"'"+studentJson.enrollments[i].course_id+"'"+"]").length == 0)
       || ($("[data-course_id = "+"'"+studentJson.enrollments[i].course_id+"'"+"]").attr("data-isopt")=="true"))

      if (studentJson.enrollments[i].course_id == $('#'+contentId).attr("data-course_id")){
        document.getElementById('infoCourseName').innerHTML = studentJson.enrollments[i].course.code + ' - ' +studentJson.enrollments[i].course.name;
        document.getElementById('lastSemester').innerHTML = studentJson.enrollments[i].year +' / '+studentJson.enrollments[i].semester;
        document.getElementById('lastGrade').innerHTML = studentJson.enrollments[i].grade;
        document.getElementById('lastFreq').innerHTML = studentJson.enrollments[i].frequency;
        document.getElementById('lastStatus').innerHTML = studentJson.enrollments[i].status;
        $('#infoTableRow').attr('class', 'infoTableRow '+getStatusClass(studentJson.enrollments[i].status));
        $('#courseInfo').css({"display": "block" });
      }

      else {
        enrollments.push(studentJson.enrollments[i]);
      }
    
  }

  if (enrollments.length > 1){
    
    text = '<tr class="infoTableTitle"><td id="infoCourseName"> </td></tr> <tr class="infoTableTitle"><td>Disciplina</td><td>Período</td><td>Nota</td><td>Frequência</td><td>Situação</td></tr>';
    for (var i = enrollments.length - 1; i >= 0; i--) {
      text += '<tr class="infoTableRow '+ getStatusClass(enrollments[i].status) +'">'+
      '<td>'+ enrollments[i].course.code + ' - ' + enrollments[i].course.name +'</td>' +
      '<td>'+ enrollments[i].year +' / '+enrollments[i].semester +'</td>' +
      '<td>'+ enrollments[i].grade +'</td>' +
      '<td>'+ enrollments[i].frequency +'</td>' +
      '<td>'+ enrollments[i].status +'</td>' +
      '</tr>';
    }
    document.getElementById('optInfoTable').innerHTML = text;
  }

}

function gridContentMouseover(contentId){

  if ($('#'+contentId).attr("data-assigned")=="true"){

    tooltip.style.display = "block";
    tooltip = document.getElementById('tooltip');
    currentCell = document.getElementById(contentId);

    tooltip.style.top = parseInt(document.getElementById(contentId).offsetTop+document.getElementById(contentId).clientHeight + 2)+'px';
    tooltip.style.left = document.getElementById(contentId).offsetLeft+'px';

    document.getElementById("tooltipStatus").innerHTML = $('#'+contentId).attr("data-status");
    document.getElementById("tooltipGrade").innerHTML = $('#'+contentId).attr("data-grade");
    document.getElementById("tooltipFreq").innerHTML = Math.round($('#'+contentId).attr("data-frequency"))+'%';
    document.getElementById("tooltipYear").innerHTML = $('#'+contentId).attr("data-year") + ' / ' + $('#'+contentId).attr("data-semester");

    $("#tooltip").show();

    $('#'+contentId).css({"text-decoration": "underline"});
  }
}

function gridContentLeave(contentId){
  $('#tooltip').hide();
  $('#'+contentId).css({"text-decoration": "none"});
}