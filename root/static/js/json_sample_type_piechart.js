google.charts.load('current', {'packages':['corechart', 'controls']});
google.charts.setOnLoadCallback(drawDashboard);

function drawDashboard() {
	var dashboard = new google.visualization.Dashboard(
	    document.getElementById('dashboard_div'));
	var data = google.visualization.arrayToDataTable(types);

	var typeFilter = new google.visualization.ControlWrapper({
	  'controlType': 'CategoryFilter',
	  'containerId': 'type_filter_div',
	  'options' : {
	    'filterColumnLabel': 'Sample Type',
	  }
	});
	var pieChart = new google.visualization.ChartWrapper({
	  'chartType': 'PieChart',
	  'containerId': 'piechart_div',
	  'options': {
            'is3D': true,
	    'pieSliceText': 'percentage',
	    'legend': 'none'
	  }, 'view' : {'columns' : [0,1]}
	});

	var tableChart = new google.visualization.ChartWrapper({
	  'chartType': 'Table',
	  'containerId': 'tablechart_div',
	  'options': {
	  }, 'view' : {'columns' : [0, 1]}
	});

	dashboard.bind(typeFilter, [pieChart, tableChart] );

	dashboard.draw(data);

}
