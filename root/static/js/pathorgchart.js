google.charts.setOnLoadCallback(pathOrgChart);

function pathOrgChart() {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'Name');
  data.addColumn('string', 'Parent');
  data.addColumn('string', 'ToolTip');
  
//data.addRows([
//  ['Sample', '', 'A specimen collected from a patient'],
//  ['Sample Number', 'Sample', 'Unique identifier for the specimen'],
//  ['Collect Date', 'Sample', 'When the sample was collected'],
//  ['Order', 'Sample', 'What Pathology Tests were ordered'],
//  ['Order Code', 'Order', 'Local Code for each order'],
//  ['Test', 'Order Code', 'Analytes to be tested for'],
//  ['Result', 'Test', 'Value obtained for Test'],
//  ['Result Date', 'Test', 'Date Result value obtained']
//]);

  data.addRows(orgchart.tree);

  var chart = new google.visualization.OrgChart(document.getElementById('path_org_chart'));
  chart.draw(data);
}
