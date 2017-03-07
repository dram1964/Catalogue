google.charts.load('current', {'packages':['corechart', 'controls']});

google.charts.setOnLoadCallback(drawDashboard);

function drawDashboard() {
	var data = google.visualization.arrayToDataTable(
	  vh_data.table);

	var dashboard = new google.visualization.Dashboard(
	    document.getElementById('dashboard_div'));

	var virusFilter = new google.visualization.ControlWrapper({
	  'controlType': 'CategoryFilter',
	  'containerId': 'virus_filter_div',
	  'options' : {
	    'filterColumnLabel': 'Virus'
	  }
	});

	var genderFilter = new google.visualization.ControlWrapper({
	  'controlType': 'CategoryFilter',
	  'containerId': 'gender_filter_div',
	  'options' : {
	    'filterColumnLabel': 'Gender'
	  }
	});

	var drugFilter = new google.visualization.ControlWrapper({
	  'controlType': 'CategoryFilter',
	  'containerId': 'drug_filter_div',
	  'options' : {
	    'filterColumnLabel': 'Drug'
	  }
	});

	var pieChart = new google.visualization.ChartWrapper({
	  'chartType': 'PieChart',
	  'containerId': 'chart_div',
	  'options': {
	    'width': 600,
	    'height': 600,
	    'pieSliceText': 'value',
	    'legend': 'left'
	  }, 'view' : {'columns' : [0,3]}
	});

	dashboard.bind([virusFilter, drugFilter, genderFilter], pieChart);

	dashboard.draw(data);
}

