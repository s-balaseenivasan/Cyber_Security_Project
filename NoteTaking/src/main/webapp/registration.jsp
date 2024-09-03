<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Sign Up</title>

<link rel="stylesheet"
	href="fonts/material-icon/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">

<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="main">
		<section class="signup">
			<div class="container">
				<div class="signup-content">
					<div class="signup-form">
						<h2 class="form-title">Sign up</h2>
					
						<form action="register" method="post" class="register-form"
							id="register-form">
							<div class="form-group">
								<label for="fname"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="fname" id="fname" required placeholder="Your First Name" />
							</div>
							<div class="form-group">
								<label for="lname"><i
										class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="lname" id="lname" required placeholder="Your Last Name" />
							</div>
							<div class="form-group">
								<label for="email"><i class="zmdi zmdi-email"></i></label> <input
									type="email" name="email" id="email" required placeholder="Your Email" />
							</div>
							<div class="form-group">
								<label for="pass"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="pass" id="pass" required placeholder="Password" />
							</div>
							<div class="form-group">
								<label for="re_pass"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="password" name="re_pass" required id="re_pass"
									placeholder="Repeat your password" />
							</div>
							<div class="form-group">
								<label for="contact"><i class="zmdi zmdi-lock-outline"></i></label>
								<input type="text" name="phone" required id="contact"
									placeholder="Contact no" />
							</div>
							<div class="form-group">
								<input type="checkbox" name="agree-term" required id="agree-term"
									class="agree-term" /> <label for="agree-term"
									class="label-agree-term"><span><span></span></span>I
									agree all statements in <a href="#" class="term-service">Terms
										of service</a></label>
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signup" id="signup"
									class="form-submit" value="Register" />
							</div>
						</form>
					</div>
					<div class="signup-image">
						<figure>
							<img src="images/signup-image.jpg" alt="sing up image">
						</figure>
						<a href="login.jsp" class="signup-image-link">I am already
							member</a>
					</div>
				</div>
			</div>
		</section>


	</div>
	<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">

	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link rel="stylesheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
		var status=document.getElementById("status").value;
		if(status == "success")
		{
			swal("congrats","Account Created Successfully","success");
		}
		if(status == "InvalidPassword")
		{
			swal("sorry","Invalid Password","error");
		}
		if(status == "PasswordMismatch")
		{
			swal("Sorry","Password is Mismatch","error");
		}
		if(status =="InvalidPhone")
		{
			swal("Sorry","Invalid Phone","error");
		}
		if(status == "InvalidPhoneLength")
		{
			swal("Sorry","Phone number should be only 10 numbers","error");
		}
		if(status == "EmailUse")
		{
			swal("Sorry","Email is Already use","error");
		}
		if(status == "InvalidEmail")
		{
			swal("Sorry","Invalid Email","error");
		}
	</script>
	<script src="js/main.js"></script>


</body>

</html>