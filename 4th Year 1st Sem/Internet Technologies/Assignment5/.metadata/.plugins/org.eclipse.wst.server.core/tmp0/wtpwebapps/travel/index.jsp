<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ page import="java.sql.*" %>
<%@ page import="travel.DAO" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="style.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">


<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>


<style>
	.title-bar{
	width: 100%;
	color: white;
	padding: 10px;
	font-family: serif;
	font-size: 100px;
	text-align: center;
	background-color: #1abc9c;
	}

	.error{
		text-align: center;
		font-size: 30px;
		font-family: serif;
	}

	.travel-form{
		margin: auto;
		align-content: center;
		display: block;
		text-align: center;
		background-color: #DBDADA;
		padding: 20px;
	}

	.travel-form form{
		display: inline-block;
	}

	.travel-form select, input{
		height: 60px;
		width: 300px;
	}

	.search{
		background-color: #000faa;
		color: white;
		font-style: strong;
		font-size: large;
		font-weight: 300;
		font-family: monospace;
		border-radius: 100px;
		border: solid;
		background-image: linear-gradient(to bottom right, #6666ff, #9999ff, #0066ff); 
	}

	.special-deals{
		width: 100%;
		padding: 10px;
		font-family: serif;
		font-size: 50px;
		text-align: center;
		color: white;
		font-family: cursive;
		background-image: linear-gradient(to bottom right, #0636ff, #0699ff, #f016ff);  
	}

	.offer{
		width: 100%;
		color: white;
		padding: 10px;
		text-align: center;
		background-color: #1abc9c;
		background-image: radial-gradient(red, yellow);
	}

	.normal-text{
		font-size: 25px;
		font-family: serif;
	}

	.discount{
		font-size: 70px;

	}

	.source{
		font-size: 60px;
	}

	/* Hide the images by default */
	.slide {
	  display: none;
	}

	/* Next & previous buttons */
	.prev, .next {
	  cursor: pointer;
	  position: absolute;
	  top: 50%;
	  width: auto;
	  margin-top: -75px;
	  padding: 16px;
	  color: white;
	  font-weight: bold;
	  font-size: 18px;
	  transition: 0.6s ease;
	  border-radius: 0 3px 3px 0;
	  user-select: none;
	}

	/* Position the "next button" to the right */
	.next {
	  right: 0;
	  border-radius: 3px 0 0 3px;
	}

	/* On hover, add a black background color with a little bit see-through */
	.prev:hover, .next:hover {
	  background-color: rgba(0,0,0,0.8);
	}



</style>

<script type="text/javascript">
	function timeDiff(target) {
		function z(n) {return (n<10? '0' : '') + n;}
		var timeDiff = target - (new Date()); 
		var hours    = timeDiff / 3.6e6 | 0;
		var minutes  = timeDiff % 3.6e6 / 6e4 | 0;
		var seconds  = timeDiff % 6e4 / 1e3 | 0;
		if (hours<0 || minutes<0 || seconds<0) {
		  document.getElementById('divBody').style.display='none';
		  document.getElementById('divExpired').style.display='';    
		  return '<b>EXPIRED</b>';
		  }
		else {
		  return '<b>' + z(hours) + '</b> h <b>' + z(minutes) + '</b>  m <b>' + z(seconds) + '</b> s';
		  }
		}

	var addFunctionOnWindowLoad = function(callback){
	  if(window.addEventListener){
		  window.addEventListener('load',callback,false);
	  }else{
		  window.attachEvent('onload',callback);
	  }
	}
</script>



<title>Home</title>
</head>
<body>

<!-- Title bar -->
<div class="title-bar">
	<h1> TravelThruAir </h1>
</div>


<%
	String url,user,pass;
	url="jdbc:mysql://localhost:3306/travel";
	System.out.println(url);
	user="root";
	pass="";
	
	DAO dao=new DAO(url,user,pass);
	ResultSet rs;
	rs=dao.getCities();
%>


<!-- Form -->
<div class="travel-form">
	<form action="search" id="travel-form" method="post">
		<select class="src" id="src" name="src">
			<%
				do
				{%>
					<option value="<%=rs.getString("code")%>"><%=rs.getString("code")%>-<%=rs.getString("city")%> </option>
				<%}
				while(rs.next());
				rs=dao.getCities();
			%>
		</select>

		<select class="dest" id="dest" name="dest">
			<%
				do
				{%>
					<option value="<%=rs.getString("code")%>"><%=rs.getString("code")%>-<%=rs.getString("city")%> </option>
				<%}
				while(rs.next());
			%>
		</select>

		<input type="date" id="date" name="date" required="">
		<input class="search" type="button" value="SEARCH" onclick="validate_and_submit()">
		
	</form>
</div>

<div class="special-deals">
	SPECIAL DEALS
</div>


<!-- Offers -->
<div class="offers-container">
	<%
		rs=dao.getOffers();
		if(rs==null)
		{%>
			<div class="error">No offers right now</div>
		<% }
		else
		{
			do
			{%>
				<div class="offer slide">
					<!-- START TIME: <%=rs.getString("start_time") %>
					END TIME: <%=rs.getString("end_time") %> -->
					<div class="normal-text">Flat</div>
					<div class="discount"><strong><%=rs.getString("discount") %>%</strong> off</div>
					<div class="normal-text">on flights</div>
					<div class="source"><strong><%=rs.getString("src") %> </strong> <span style='font-size:75px;'>&#8594;</span> <strong><%=rs.getString("dest") %> </strong></div>
					<div class="normal-text"><div id="countdown<%=rs.getString("id")%>"></div>

						<script language="javaScript">              
						  function doCountDown<%=rs.getString("id")%>(target) {
							document.getElementById('countdown<%=rs.getString("id")%>').innerHTML = '<span style=\"color:white\"><b>EXPIRES IN</b></span>: ' + timeDiff(target);
							var lag = 1020 - (new Date() % 100);
							setTimeout(function(){doCountDown<%=rs.getString("id")%>(target);}, lag);
							}
						  var x<%=rs.getString("id")%> = function doStart<%=rs.getString("id")%>() {
							//Insert Expiration Date from mySQL into t var
							var t="<%=rs.getString("end_time")%>".split(/[- :]/);
							doCountDown<%=rs.getString("id")%>(new Date(t[0],t[1]-1,t[2],t[3],t[4],t[5]));
						  }
						  addFunctionOnWindowLoad(x<%=rs.getString("id")%>);

						</script> 
					</div> 
				</div>

				<!-- Next and previous buttons -->
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
				<a class="next" onclick="plusSlides(1)">&#10095;</a>
			<%}
			while(rs.next());
		}
	%>
</div>

</body>

<script type="text/javascript">
	var today = new Date().toISOString().split('T')[0];
	document.getElementsByName("date")[0].setAttribute('min', today);


	//Script for slideshow
	var slideIndex = 1;
	showSlides(slideIndex);
	showSlidesAuto();

	// Next/previous controls
	function plusSlides(n) {
	  showSlides(slideIndex += n);
	}

	// Thumbnail image controls
	function currentSlide(n) {
	  showSlides(slideIndex = n);
	}

	function showSlides(n) {
	  var i;
	  var slides = document.getElementsByClassName("slide");
	  console.log(slides.length);
	  if (n > slides.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = slides.length}
	  for (i = 0; i < slides.length; i++) {
		  slides[i].style.display = "none";
	  }
	  slides[slideIndex-1].style.display = "block";
	}

	function showSlidesAuto() {
	  var i;
	  var slides = document.getElementsByClassName("slide");
	  for (i = 0; i < slides.length; i++) {
	    slides[i].style.display = "none";
	  }
	  slideIndex++;
	  if (slideIndex > slides.length) {slideIndex = 1}
	  slides[slideIndex-1].style.display = "block";
	  setTimeout(showSlidesAuto, 5000); // Change image every 2 seconds
	}

	function validate_and_submit(){
		var src=document.getElementById("src").value;
		var dest=document.getElementById("dest").value;
		if(src===dest)
		{
			//Error
			alert("Source and destination city cannot be same");
		}
		else
			document.getElementById("travel-form").submit();
	}


</script>

</html>