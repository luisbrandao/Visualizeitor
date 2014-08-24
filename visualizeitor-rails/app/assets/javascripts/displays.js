var studentJson;
var programJson;

jQuery(document).ready(function($) {
  registerCallbacks();
  didClickButtonSearchGRR();
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
  $(".gridContent").dblclick(function (){
    window.scrollTo(0,document.body.scrollHeight);
    gridContentClick(this.id);
  });
  $(".tabSelector").click(function (){
    tabChange(this.id);
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
  $('#optContainer').css({"display": "none" });

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
    itemId = program_items[i].id;
    courseId = program_items[i].course_id;
    courseName = program_items[i].course.name;
    courseCode = program_items[i].course.code;

    selectedCell = document.getElementById('gridCell-'+rowId+'-'+colId);

    if(courseCode == "OPT"){ 
      optCount++;
      text =  '<div class="gridContent statusDefault"  id=gridContent-' +itemId+' data-courseid= '+courseId+' data-type= "OPT'+optCount+'" data-assigned= "false">';
    }
    else if(courseCode == "TGI"){
      text =  '<div class="gridContent statusDefault"  id=gridContent-' +itemId+' data-courseid= '+courseId+' data-type = "TGII" data-assigned = "false">';
    }
    else if(courseCode == "TGII"){
      text =  '<div class="gridContent statusDefault"  id=gridContent-' +itemId+' data-courseid= '+courseId+' data-type = "TGI" data-assigned = "false">';
    }
    else {
      text =  '<div class="gridContent statusDefault"  id=gridContent-' +itemId+' data-courseid= '+courseId+' data-assigned = "false">';
    }

    text += '<div class="gridCourseCode">'+ courseCode +'<span class="enrollCount"></span></div>'
        + '<div class="gridCourseName">'+ courseName +'</div>'
        + '</div>';

    selectedCell.innerHTML += text;
  }
  
  //cellWidth = 100/(colCount+1) - 0.5;

  //cellWidth = cellWidth+"%"
  //$('.gridCol').css({"width": cellWidth });

  setGridStatus();
  getChartData();
  registerCallbacks();

}


function setGridStatus(){

  var enrollments = studentJson.enrollments;
  var arrayOpt = [];

  document.getElementById('optCells').innerHTML = "";

  document.getElementById('studentName').innerHTML = studentJson.name;
  document.getElementById('studentGrr').innerHTML = studentJson.grr;
  //document.getElementById('programName').innerHTML = programJson.name;

  for (i in enrollments){
    if ($('[data-courseid = "'+enrollments[i].course_id+'"]').length > 0){  
      applyEnrollment($('[data-courseid = "'+enrollments[i].course_id+'"]').attr("id"), enrollments[i]);
    }
    else if(enrollments[i].enrollment_type == "Trabalho de Graduação I"){
      if ($("[data-type = 'TGI']").length != 0)
        applyEnrollment($("[data-type = 'TGI']").attr("id"), enrollments[i]);
    }

    else if(enrollments[i].enrollment_type == "Trabalho de Graduação II"){
       if($("[data-type = 'TGII']").length != 0)
        applyEnrollment($("[data-type = 'TGII']").attr("id"), enrollments[i]);
    }
    else arrayOpt.push(enrollments[i]);

  }
  setOptStatus(arrayOpt);   
}


function setOptStatus(enrollments){

  var optCount = 1;

  for (i in enrollments){
    if (enrollments[i].status == 'Dispensa de Disciplinas (com nota)'
      || enrollments[i].status == 'Aprovado'
      || enrollments[i].status == 'Matrícula'
      || enrollments[i].status == 'Equivalência de Disciplina')
    {
      text =  '<div class="gridCourseCode">'+ enrollments[i].course.code+' <span class="opttag">*</span> </div>'
            + '<div class="gridCourseName">'+ enrollments[i].course.name +'</div>';

      if ($('[data-courseid = "'+enrollments[i].course_id+'"]').length > 0)
        selectedId = $('[data-courseid = "'+enrollments[i].course_id+'"]').attr("id");

      else if($('[data-type= "OPT'+optCount+'"]').length != 0) {

        selectedId = $("[data-type= OPT"+optCount+"]").attr("id");
        document.getElementById(selectedId).innerHTML = text;
        optCount++;
      }
      else {
        text2 = '<div class="gridContent statusDefault optCell" id=gridContent-' +enrollments[i].id
            +' data-courseid= '+enrollments[i].course_id+' data-type= OPT'+optCount+' data-assigned= "false">'
            + text
            + '</div>';
        document.getElementById("optCells").innerHTML += text2;
        selectedId = $("[data-type= OPT"+optCount+"]").attr("id");
        optCount++;

        $('#'+selectedId).css({
          "height":$(".gridContent").height(),
          "width":$(".gridContent").width(),
          "margin": "3px",
          "float": "left"
        });   
      }
      applyEnrollment(selectedId, enrollments[i]);
    }
  }
  i = 0;
  for (i in enrollments){
    text =  '<div class="gridCourseCode">'+ enrollments[i].course.code+' <span class="opttag">*</span><span class="enrollCount"></span></div>'
          + '<div class="gridCourseName">'+ enrollments[i].course.name +'</div>';

    if ($('[data-courseid = "'+enrollments[i].course_id+'"]').length > 0)
      selectedId = $('[data-courseid = "'+enrollments[i].course_id+'"]').attr("id");

    else if($('[data-type= "OPT'+optCount+'"]').length != 0) {

      selectedId = $("[data-type= OPT"+optCount+"]").attr("id");
      document.getElementById(selectedId).innerHTML = text;
      optCount++;
    }
    else {
      text2 = '<div class="gridContent statusDefault optCell" id=gridContent-' +enrollments[i].id
          +' data-courseid= '+enrollments[i].course_id+' data-type= OPT'+optCount+' data-assigned= "false">'
          + text
          + '</div>';
      document.getElementById("optCells").innerHTML += text2;
      selectedId = $("[data-type= OPT"+optCount+"]").attr("id");
      optCount++;

      $('#'+selectedId).css({
        "height":$(".gridContent").height(),
        "width":$(".gridContent").width(),
        "margin": "3px",
        "float": "left"
      });     

    }

    applyEnrollment(selectedId, enrollments[i]);    

  }
  if (document.getElementById('optCells').innerHTML != "")
    $('#optContainer').css({"display": "block" });


  //$(".optCell").height( $(".gridContent").height() ).width( $(".gridContent").width());
}

function applyEnrollment(contentId, enrollment){
  $('#'+contentId).attr('data-assigned', "true");
  $('#'+contentId).attr('class', 'gridContent '+getStatusClass(enrollment.status));
  $('#'+contentId).attr('data-courseid', enrollment.course_id);

  count = countEnrollments(enrollment.course_id);
  if(count > 1)
    $('#'+contentId+'> .gridCourseCode > .enrollCount').html(count).show();
  //$('#'+contentId).attr('data-status', enrollment.status);
  //$('#'+contentId).attr('data-enrollment_id', enrollment.id);
  //$('#'+contentId).attr('data-semester', enrollment.semester);
  //$('#'+contentId).attr('data-year', enrollment.year);
  //$('#'+contentId).attr('data-frequency', enrollment.frequency);    
  //$('#'+contentId).attr('data-grade', enrollment.grade);
  //$('#'+contentId).attr('data-enrollment_id', enrollment.id);
}

function countEnrollments(courseId){
  var count = 0;
  for(i in studentJson.enrollments)
    if(studentJson.enrollments[i].course_id == courseId)
      count++;
  return count;
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
    default: 'statusSuspended';
  }
}

function gridContentClick(contentId){
  updateCourseInfo(contentId)
}

function updateCourseInfo (contentId){
  var enrollments = [];

  courseId = $('#'+contentId).attr('data-courseid');

  if ($("[data-courseid = "+"'"+courseId+"'"+"]").attr("data-assigned")=="true"){

    $("[data-selected = 'true']").attr('data-selected', 'false');
    $('#'+contentId).attr('data-selected', "true"); 
    $('#courseInfo').css({"display": "block" });

    for(i in studentJson.enrollments)
      if (studentJson.enrollments[i].course_id == courseId)
        enrollments.push(studentJson.enrollments[i]);
    
    document.getElementById('infoCourseName').innerHTML = enrollments[enrollments.length-1].course.code + ' - ' + enrollments[enrollments.length-1].course.name;
    document.getElementById('lastSemester').innerHTML = enrollments[enrollments.length-1].year +'/'+enrollments[enrollments.length-1].semester;
    document.getElementById('lastGrade').innerHTML = enrollments[enrollments.length-1].grade;
    document.getElementById('lastFreq').innerHTML = enrollments[enrollments.length-1].frequency;
    document.getElementById('lastStatus').innerHTML = enrollments[enrollments.length-1].status;
    document.getElementById('infoCourseType').innerHTML = enrollments[enrollments.length-1].enrollment_type;

    $('#infoTableRow').attr('class', 'infoTableRow '+getStatusClass(enrollments[enrollments.length-1].status)); 

    if (enrollments.length > 1){
      $('#courseOldInfo').css({"display": "block" })  

      text = '<tr class="infoTableTitle">'+
      '<td id="infoCourseName"> </td></tr>'+
      '<tr class="infoTableTitle">'+
      '<td class="cellSemester">Período</td>'+
      '<td class="cellGrade">Nota</td>'+
      '<td class="cellFreq">Freq.</td>'+
      '<td class="cellStatus">Situação</td></tr>';
      for (var i = enrollments.length - 2; i >= 0; i--) {
        text += '<tr class="infoTableRow '+ getStatusClass(enrollments[i].status) +'">'+
        '<td>'+ enrollments[i].year +'/'+enrollments[i].semester +'</td>' +
        '<td>'+ enrollments[i].grade +'</td>' +
        '<td>'+ enrollments[i].frequency +'</td>' +
        '<td>'+ enrollments[i].status +'</td>' +
        '</tr>';
      }
      document.getElementById('oldInfoTable').innerHTML = text;
    }
    else $('#courseOldInfo').css({"display": "none" });
  }

}


function getChartData(){

    var studentId = studentJson.id;

    $.ajax({
            url: '/students/' + studentId + '/enrollments/ira_chart.json',
            type: 'get',
            data: {},
            success: function (data) {
              loadChart(data);
            }
        });
}


function loadChart(data)
{
  gradeFloat = []
  for (i = 0; i < data.grade_average.length; i++) {
    gradeFloat[i] = parseFloat(data.grade_average[i]);
  }
        $('#chartContainer').highcharts({
            lang:{
                  printChart: "Imprimir Gráfico",
                  downloadPNG:"Baixar como imagem PNG",
                  downloadJPEG:"Baixar como imagem JPEG",
                  downloadPDF:"Baixar como documento PDF",
                  downloadSVG:"Baixar como imagem SVG",
                  contextButtonTitle:"Chart context menu"
            },
            exporting: {
                enabled: true,

            },
            plotOptions: {
              series: {
                animation: false
              }
            },
            credits: {
                enabled: false
            },
            chart: {
                zoomType: 'x',
                style:{
                  fontFamily: 'Lato'              
                 
                }
            },
            title: {
                text: 'Notas e Quantidade de Disciplinas por Semestre'
            },
            xAxis: [{
                categories: data.years
            }],
            yAxis: [{ // Primary yAxis
              min: 0,
              max: 100,
                labels: {
                    format: '{value}',
                    style: {
                        color: Highcharts.getOptions().colors[1]
                    }
                },
                title: {
                    text: 'Nota',
                    style: {
                        color: Highcharts.getOptions().colors[1]
                    }
                }
            }, { // Secondary yAxis
                title: {

                    text: 'Quantidade de Disciplinas',
                    style: {
                        color: '#353C42'
                    }
                },
                labels: {
                    format: '{value}',
                    style: {
                        color: '#458F8C'
                    }
                },
                opposite: true
            }],
            tooltip: {
                shared: true
            },
            
            series: [{
              color: '#458F8C',
                name: 'Quantidade de Disciplinas',
                type: 'column',
                yAxis: 1,
                data: data.total_enrollments,
                tooltip: {
                }
    
            }, {
                name: 'Nota',
                color: '#353C42',
                marker: {
                lineWidth: 2,
                lineColor: '#353C42',
                fillColor: '#BCD3E7'
              },
                data: gradeFloat,
                lineWidth: 2,

            }]
        });

}

function tabChange(tabId){

  $('#chartContainer').hide();
  $('.tabSelector').removeClass('selectedTab');
  $('#'+tabId).addClass('selectedTab');

  $('.tabContent').hide();

  $('#'+tabId+'Content').show();

  if (tabId == 'chartTab'){
    getChartData()
    $('#chartContainer').show();
  }

}