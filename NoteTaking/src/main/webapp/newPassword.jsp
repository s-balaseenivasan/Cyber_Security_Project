<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reset Password</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>

    <style>
        .placeicon {
            font-family: 'FontAwesome';
        }

        .custom-control-label::before {
            background-color: #dee2e6;
            border: #dee2e6;
        }
    </style>
</head>
<body class="bg-info">
    <!-- Container -->
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-9 col-lg-7 col-xl-6 mt-5">
                <!-- White Container -->
                <div class="container bg-white rounded px-3 py-4">
                    <!-- Main Heading -->
                    <div class="row justify-content-center mb-4">
                        <h1><strong>Reset Password</strong></h1>
                    </div>
                    <div>
                        <form class="form-horizontal" action="newPassword" method="POST">
                            <!-- New Password Input -->
                            <div class="form-group row">
                                <div class="col-12">
                                    <input type="password" name="password" placeholder="&#xf084; &nbsp; New Password" class="form-control border-info placeicon" required>
                                </div>
                            </div>
                            <!-- Confirm Password Input -->
                            <div class="form-group row">
                                <div class="col-12">
                                    <input type="password" name="confPassword" placeholder="&#xf084; &nbsp; Confirm New Password" class="form-control border-info placeicon" required>
                                </div>
                            </div>
                            <!-- Reset Button -->
                            <div class="form-group row">
                                <div class="col-12">
                                    <input type="submit" value="Reset" class="btn btn-block btn-info">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
