$(document).ready(function() {
	var programId = $('#program_id').val();

	var url = '/programs/'+ programId + '.json';

  $.ajax({
      url: url,
      type: 'get',
      data: {},
      success: function (data) {
        var $container = $('#program-container');
        drawProgram(data, $container);
      }
    });
});
