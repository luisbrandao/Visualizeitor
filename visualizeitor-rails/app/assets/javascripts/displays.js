jQuery(document).ready(function($) {
  registerCallbacks();
});

function registerCallbacks()
{
	$(document).on('click', '#buttonSearchGRR', function(event) {
    event.preventDefault();
    didClickButtonSearchGRR();
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
        didDownloadProgram(data, student);
      }
    });
};

function didDownloadProgram(program, student)
{
  var stringified = JSON.stringify(program, null, 2);  
  $('#program-result').html(stringified);
  drawGrid(program, student);
}

function drawGrid(programJson, studentJson){

  var text = "";
  var program_items = programJson.program_items;
  var gridContainer = document.getElementById('gridContainer');
  var optCount = 0;
  var colCount = 0;
  var rowCount = 0;

  for (i in program_items) {
    if(program_items[i].column > colCount)
      var colCount = program_items[i].column;
    if(program_items[i].row > rowCount)
      var rowCount = program_items[i].row;
  }

  //console.log(rowCount);
  //console.log(colCount);
	
  gridContainer.innerHTML = '';

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
    courseName = toTitleCase(program_items[i].course.name);
    courseCode = program_items[i].course.code;

    selectedCell = document.getElementById('gridCell-'+rowId+'-'+colId);

    //optativa
    if(courseId == 34){ 
      text =  '<div class="gridContent statusDefault"  id=gridContent-' + courseId + '-opt'+optCount+' data-set = "false">'
      + '<div class="gridCourseCode">'+ courseCode +'</div>'
      + '<div class="gridCourseName">'+ courseName +'</div>'
      + '</div>';

      optCount++;
    }
    else {
      text =  '<div class="gridContent statusDefault"  id=gridContent-' + courseId + ' data-set = "false">'
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

  $(".gridContent").mouseover(function (){

    if ($('#'+this.id).attr("data-set")=="true"){

    tooltip.style.display = "block";
    tooltip = document.getElementById('tooltip');
    currentCell = document.getElementById(this.id);

    tooltip.style.top = parseInt(document.getElementById(this.id).offsetTop+document.getElementById(this.id).clientHeight + 2)+'px';
    tooltip.style.left = document.getElementById(this.id).offsetLeft+'px';

    document.getElementById("tooltipStatus").innerHTML = $('#'+this.id).attr("data-status");
    document.getElementById("tooltipGrade").innerHTML = $('#'+this.id).attr("data-grade");
    document.getElementById("tooltipFreq").innerHTML = Math.round($('#'+this.id).attr("data-frequency"))+'%';
    document.getElementById("tooltipYear").innerHTML = $('#'+this.id).attr("data-year") + ' / ' + $('#'+this.id).attr("data-semester");

    $("#tooltip").show();

    //$('#'+this.id).css({"text-decoration": "underline" });
    //$("#tooltip").css({"opacity": "1" });

    //$("#tooltip").fadeTo( "400" , 1);
    }
  });

  $(".gridContent").mouseleave(function (){
    $("#tooltip").hide();
    //$('#'+this.id).css({"text-decoration": "none" });
    
    //$("#tooltip").fadeTo( "400" , 0);
  });


  $("#tooltip").click(function(){
    $(this).hide();

  });

  /*
  $(".gridContent").mousedown(function(event) {
    //console.log(event.which);

    if (event.which == 3){

      $("#tooltip2").show();
      tooltip2 = document.getElementById('tooltip2');

      tooltip2.style.top = event.pageY+'px';
      tooltip2.style.left = event.pageX+'px';


    }
    else if (event.target.className != "tooltip" ){
      
      $("#tooltip2").hide();
    }
  
  });


  */




}
function toTitleCase(str)
{
  //return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    return str.replace(/\w\S*/g, function(txt){return txt.charAt(0) + txt.substr(1).toLowerCase();});
}




function setGridStatus(studentJson){

  enrollments = studentJson.enrollments;
  optCount = 0;

  for (i in enrollments){
    status = enrollments[i].status;
    courseId = enrollments[i].course_id;
    enrollmentId = enrollments[i].id;
    semester = enrollments[i].semester;
    year = enrollments[i].year;
    grade = enrollments[i].grade;
    frequency = enrollments[i].frequency;
    //console.log(status);

    if (document.getElementById('gridContent-'+courseId) != null){

      selectedId = 'gridContent-'+courseId;
    }
    else {
      text =  '<div class="gridCourseCode">'+ enrollments[i].course.code+' (OPT) </div>'
        + '<div class="gridCourseName">'+ enrollments[i].course.name +'</div>';

      document.getElementById('gridContent-34-opt'+optCount).innerHTML = text;

      selectedId = 'gridContent-34-opt'+optCount;

      optCount++;
    }

      $('#'+selectedId).attr('class', 'gridContent '+getStatusClass(status));
      $('#'+selectedId).attr('data-set', "true");
      $('#'+selectedId).attr('data-status', status);
      $('#'+selectedId).attr('data-enrollmentId', enrollmentId);
      $('#'+selectedId).attr('data-semester', semester);
      $('#'+selectedId).attr('data-year', year);
      $('#'+selectedId).attr('data-frequency', frequency);  
      $('#'+selectedId).attr('data-grade', grade);
        



  }

}



function getStatusClass(status){

  switch(status){
    case 'Reprovado por Frequência':
    return 'statusFailed';
    break;
    case 'Reprovado por nota':
    return 'statusFailed';
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
  }
}


