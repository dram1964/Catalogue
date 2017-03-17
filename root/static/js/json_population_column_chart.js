google.charts.load('current', {'packages':['corechart','table', 'controls']});
    google.charts.setOnLoadCallback(drawPopulationBarChart);

    function drawPopulationBarChart() {

    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Age Range');
    data.addColumn('number', 'Population');
    data.addRows(ranges);

    var options = {
      title: populationTitle
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('population_column_chart_div'));
    var table = new google.visualization.Table(document.getElementById('table_chart_div'));

    chart.draw(data, options);
    table.draw(data, options);
}

