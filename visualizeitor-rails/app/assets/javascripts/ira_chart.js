jQuery(document).ready(function($) {

    var studentId = $('#student_id').val();

    $.ajax({
            url: '/students/' + studentId + '/enrollments/ira_chart.json',
            type: 'get',
            data: {},
            success: function (data) {
                loadChart(data);
            }
        });
});

function loadChart(data)
{
	gradeFloat = []
	for (i = 0; i < data.grade_average.length; i++) {
		gradeFloat[i] = parseFloat(data.grade_average[i]);
	}


        $('#container').highcharts({
            chart: {
                zoomType: 'x'
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
                        color: '#306E73'
                    }
                },
                opposite: true
            }],
            tooltip: {
                shared: true
            },
            
            series: [{
            	color: '#306E73',
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