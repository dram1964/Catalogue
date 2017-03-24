google.charts.setOnLoadCallback(pathOrgChart);

function pathOrgChart() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'Name');
  data.addColumn('string', 'Parent');
  data.addColumn('string', 'ToolTip');
  
  data.addRows(orgchart.tree);

  var chart = new google.visualization.OrgChart(document.getElementById('path_org_chart'));
  chart.draw(data);
}
