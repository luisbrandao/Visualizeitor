$(document).ready(function() {
	var programId = $('#program_id').val();

	alert('O program id é: ' + programId);

	var url = '/programs/'+ programId + '.json';

	jQuery.ajax({
	  url: url,
	  type: 'GET',
	  dataType: 'json',
	  complete: function(xhr, textStatus) {
	    //called when complete
	  },
	  success: function(data, textStatus, xhr) {
	    //called when successful
	    var stringified = JSON.stringify(data, null, 2);	
	    $('#result').html(stringified);
	    // alert(data);
	  },
	  error: function(xhr, textStatus, errorThrown) {
	    //called when there is an error
	  }
	});
	
});
