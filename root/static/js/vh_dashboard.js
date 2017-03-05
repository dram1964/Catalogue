google.charts.load('current', {'packages':['corechart', 'controls']});

google.charts.setOnLoadCallback(drawDashboard);

function drawDashboard() {
	var data = google.visualization.arrayToDataTable([
	  ['Name', 'Donuts eaten'],
	  ['Michael' , 5],
	  ['Elisa', 7],
	  ['Robert', 3],
	  ['John', 2],
	  ['Jessica', 6],
	  ['Aaron', 1],
	  ['Margareth', 8]
	]);

	var dashboard = new google.visualization.Dashboard(
	    document.getElementById('dashboard_div'));

	var donutRangeSlider = new google.visualization.ControlWrapper({
	  'controlType': 'NumberRangeFilter',
	  'containerId': 'filter_div',
	  'options': {
	    'filterColumnLabel': 'Donuts eaten'
	  }
	});

	var pieChart = new google.visualization.ChartWrapper({
	  'chartType': 'PieChart',
	  'containerId': 'chart_div',
	  'options': {
	    'width': 300,
	    'height': 300,
	    'pieSliceText': 'value',
	    'legend': 'right'
	  }
	});

	// Establish dependencies, declaring that 'filter' drives 'pieChart',
	// so that the pie chart will only display entries that are let through
	// given the chosen slider range.
	dashboard.bind(donutRangeSlider, pieChart);

	// Draw the dashboard.
	dashboard.draw(data);
}

