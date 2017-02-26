google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

var data = google.visualization.arrayToDataTable(pie.ranges);

var options = {
  title: pie.myTitle
};

var chart = new google.visualization.PieChart(document.getElementById(pie.id));

chart.draw(data, options);
}
