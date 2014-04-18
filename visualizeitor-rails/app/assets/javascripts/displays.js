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
        var stringified = JSON.stringify(data, null, 2);  
        $('#result').html(stringified);
      }
    });

}

