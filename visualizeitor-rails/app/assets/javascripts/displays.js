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
        didDownloadProgram(data);
      }
    });
};

function didDownloadProgram(program)
{
  var stringified = JSON.stringify(program, null, 2);  
  $('#program-result').html(stringified);
}

