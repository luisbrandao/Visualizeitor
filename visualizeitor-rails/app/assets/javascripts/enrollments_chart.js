jQuery(document).ready(function($) {

    var courseId = $('#course_id').val();

    $.ajax({
            url: '/courses/' + courseId + '/enrollments/chart.json',
            type: 'get',
            data: {},
            success: function (data) {
                loadChart1(data);
            }
        });
});

function loadChart1(data){
        
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        exporting: {
            enabled: true
        },
        credits: {
            enabled: false
        },
        title: {
            text: 'Situação das Matrículas'
        },
        xAxis: {
            categories: data.years
        },
        yAxis: {
            title: {
                text: 'Número de Matrículas'
            }
        },
        tooltip: {
            formatter: function() {
                return '<b>'+ this.x +'</b><br/>'+
                    this.series.name +': '+ this.y +'<br/>'+
                    'Total Matrículas: '+ this.point.stackTotal;
            }
        },
        plotOptions: {
                column: {
                    stacking: 'normal',
                }
        },
        series: [{
            name: 'Alunos Aprovados',
            data: data.approved,
            color: '#2ecc71'        
 
        }, {
            name: 'Alunos Reprovados por Nota',
            data: data.disapproved_grade_number,
            color: '#e74c3c'
        },
        {
            name: 'Alunos Reprovados por Frequência',
            data: data.disapproved_frequency_number,
            color: '#e67e22'
        }]



    });

};