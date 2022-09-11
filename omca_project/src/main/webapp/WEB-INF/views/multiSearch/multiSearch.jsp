<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<head>
<meta charset="UTF-8">
<title>MultiSearch</title>
 <style type="text/css">
      canvas { border: 1px solid black; }
    </style>
</head>
<body>
	<div>
		<pre id="result"></pre>
	</div>
	<h1>MultiSearch</h1>
	<div id="columnchart_material" style="width: 500px; height: 300px;"></div>

	<canvas id="myChart" width="200" height="200"></canvas>

<script>
const graph_data = {
		  labels: [
		    '15분 골드 차이',
		    '생존',
		    '시야',
		    '성장',
		    '전투'
		  ],
		  datasets: [{
		    label: 'My First Dataset',
		    data: [1.3, 0.7, 0.6, 1.48, 1.05],
		    fill: true,
		    backgroundColor: 'rgba(255, 99, 132, 0.2)',
		    borderColor: 'rgb(255, 99, 132)',
		    pointBackgroundColor: 'rgb(255, 99, 132)',
		    pointBorderColor: '#fff',
		    pointHoverBackgroundColor: '#fff',
		    pointHoverBorderColor: 'rgb(255, 99, 132)'
		  }, {
		    label: 'My Second Dataset',
		    data: [1, 1, 1, 1, 1],
		    fill: true,
		    backgroundColor: 'rgba(54, 162, 235, 0.2)',
		    borderColor: 'rgb(54, 162, 235)',
		    pointBackgroundColor: 'rgb(54, 162, 235)',
		    pointBorderColor: '#fff',
		    pointHoverBackgroundColor: '#fff',
		    pointHoverBorderColor: 'rgb(54, 162, 235)'
		  }]
		};

const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
    type: 'radar',
    data: graph_data,
    options : {
    	    scales: {
    	        r: {
    	       
    	            ticks: {
    	                stepSize: 0.1
    	            }
    	        }
    	}
    }
});
</script>

<script>

let aa;
let snmae;
sname = {'value' : '베란다고양이'};

requestInfoFromPython(sname);

function requestInfoFromPython(request) {
	$.ajax({
		type : 'post',
		url : 'http://127.0.0.1:5000/multi',
		data : sname,
		dataType : 'json',
		success : function(res) {
			let tmp = res;
			let str = JSON.stringify(tmp);
			alert('received from python : ' + str);
			$('#result').append(str)
			graph_list = res;
			for (var i = 0; i < graph_list.length; i++) {
				let tmp_g15_lst = [];
				let tmp_gold_lst = [];
				let tmp_vscore_lst = [];
				let tmp_dealt_lst = [];
				let tmp_deaths_lst = [];
				let tmp_map = new Map();
				for (var dif in graph_list[i]) {
					console.log(dif,graph_list[i][dif]);				
				}// End for in
				console.log(graph_list[i]);
			} //End for
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("XMLHttpRequest : " + XMLHttpRequest + ' textStatus : '
					+ textStatus + ' errorThrown : ' + errorThrown);
		}
	})
} //End requestInfoFromPython

google.charts.load('current', {'packages':['bar']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
  var data = google.visualization.arrayToDataTable([
    ['GRAPH', 'Sales', 'Expenses', 'Profit'],
    ['2014', 1000, 400, 200],
    ['2015', 1170, 460, 250],
    ['2016', 660, 1120, 300],
    ['2017', 1030, 540, 350],
    ['2017', 1030, 540, 350],
  ]);

  var options = {
    chart: {
      title: 'Company Performance',
      subtitle: 'Sales, Expenses, and Profit: 2014-2017',
    }
  };

  var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

  chart.draw(data, google.charts.Bar.convertOptions(options));
}
</script>
</body>
</html>