<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="com.shashi.service.impl.*, com.shashi.service.*,com.shashi.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"%>
<!DOCTYPE html>
<html>
<head>
<title>Payments</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet" href="css/changes.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>	
<script 
	src="https://www.paypal.com/sdk/js?client-id=YOUR_CLIENT_ID"></script>	
</head>
<script 
	src="https://www.paypal.com/sdk/js?client-id=test&components=buttons,marks"></script>
	
<body style="background-color: #E6F9E6;">

	<%
	/* Checking the user credentials */
	String userName = (String) session.getAttribute("username");
	String password = (String) session.getAttribute("password");

	if (userName == null || password == null) {

		response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
	}

	String sAmount = request.getParameter("amount");

	double amount = 0;

	if (sAmount != null) {
		amount = Double.parseDouble(sAmount);
	}
	%>



	<jsp:include page="header.jsp" />

	<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			<form action="./OrderServlet" method="post"
				class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 2px; background-color: #0000; padding: 1px;">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						
						<h2 style="color: green;">Payment Method</h2>
					</div>
				</div>
				
				</div>
			</form>
		</div>
	</div>
	
	<div class="container">
		<div class="row"
			style="margin-top: 6px; margin-left: 2px; margin-right: 2px;">
			<form action="./OrderServlet" method="post"
				class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 10px; background-color: #0000; padding: 10px;">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						<img src="images/visa_pic.png" alt="Payment Proceed" height="20px" />
						<h3 style="color: green;">Credit Card Payment</h3>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label for="last_name">Name of Card Holder</label> <input
							type="text" placeholder="Enter Card Holder Name"
							name="cardholder" class="form-control" id="last_name" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12 form-group">
						<label for="last_name">Enter Credit Card Number</label> <input
							type="number" placeholder="4242-4242-4242-4242" name="cardnumber"
							class="form-control" id="last_name" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6 form-group">
						<label for="last_name">Expiry Month</label> <input type="number"
							placeholder="MM" name="expmonth" class="form-control" size="2"
							max="12" min="00" id="last_name" required>
					</div>
					<div class="col-md-6 form-group">
						<label for="last_name">Expiry Year</label> <input type="number"
							placeholder="YYYY" class="form-control" size="4" id="last_name"
							name="expyear" required>
					</div>
				</div>
				<div class="row text-center">
					<div class="col-md-6 form-group">
						<label for="last_name">Enter CVV</label> <input type="number"
							placeholder="123" class="form-control" size="3" id="last_name"
							name="expyear" required> <input type="hidden"
							name="amount" value="<%=amount%>">

					</div>
					<div class="col-md-6 form-group">
						<label>&nbsp;</label>
						<button type="submit" class="form-control btn btn-success">
							Pay :Rs
							<%=amount%></button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="container">
		<div class="row"
			style="margin-top: 5px; margin-left: 2px; margin-right: 2px;">
			<form action="./OrderServlet" method="post"
				class="col-md-6 col-md-offset-3"
				style="border: 2px solid black; border-radius: 10px; background-color: #0000; padding: 10px;">
				<div style="font-weight: bold;" class="text-center">
					<div class="form-group">
						
						<img src="images/Paypal_logo.png" alt="Payment Proceed" height="50px" />
						<h3 style="color: green;">PayPal Payment</h3>
						

						<label>
						  <input type="radio" name="payment-option" value="paypal" checked>
						  <div id="paypal-marks-container"></div>
						</label>
						
					
						<div id="paypal-buttons-container"></div>
						<div id="alternate-button-container">
						  <button>Pay now</button>
						</div>
						
						<script>
						  paypal.Marks().render('#paypal-marks-container');
						
						  paypal.Buttons().render('#paypal-buttons-container');
						
						  // Listen for changes to the radio buttons
						  document.querySelectorAll('input[name=payment-option]')
						    .forEach(function (el) {
						      el.addEventListener('change', function (event) {
						
						        // If PayPal is selected, show the PayPal button
						        if (event.target.value === 'paypal') {
						          document.body.querySelector('#alternate-button-container')
						            .style.display = 'none';
						          document.body.querySelector('#paypal-buttons-container')
						            .style.display = 'block';
						        }
						
						        // If alternate funding is selected, show a different button
						        if (event.target.value === 'alternate') {
						          document.body.querySelector('#alternate-button-container')
						            .style.display = 'block';
						          document.body.querySelector('#paypal-buttons-container')
						            .style.display = 'none';
						        }
						      });
						    });
						
						  // Hide non-PayPal button by default
						  document.body.querySelector('#alternate-button-container')
						    .style.display = 'none';
						</script>
						
						
					</div>
				</div>
				
				</div>
			</form>
		</div>
	</div>

	<!-- ENd of Product Items List -->


	<%@ include file="footer.html"%>

</body>
</html>