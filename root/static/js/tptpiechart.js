google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

var data = google.visualization.arrayToDataTable(tptPie.ranges);

var options = {
  title: tptPie.myTitle
};

var chart = new google.visualization.PieChart(document.getElementById(tptPie.id));

chart.draw(data, options);
}
