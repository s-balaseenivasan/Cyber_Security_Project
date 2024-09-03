<%
    if (session == null || session.getAttribute("email") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Index</title>
    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons -->
    <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="css/index-styles.css" rel="stylesheet" />
</head>
<body id="page-top">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav">
        <div class="container-fluid">
            <a class="navbar-brand" href="#page-top">FortiNote</a>
            <button class="navbar-toggler text-uppercase font-weight-bold bg-primary text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                Menu <i class="fas fa-bars"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarResponsive">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#app">Application</a></li>
                    <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="#about">About</a></li>
                    <li class="nav-item mx-0 mx-lg-1 bg-danger"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="logout">Logout</a></li>
                    <li class="nav-item mx-0 mx-lg-1 bg-primary"><a data-bs-toggle="modal" data-bs-target="#profileModal" class="nav-link py-3 px-0 px-lg-3 rounded" href="#!"><%= session.getAttribute("fname") %></a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Profile Modal -->
    <div class="modal fade" id="profileModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="profileModalLabel">Profile</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="table">
                        <tbody>
                        <tr>
                            <th>User Name</th>
                            <td><%= session.getAttribute("fname") %> <%= session.getAttribute("lname") %></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%= session.getAttribute("email") %></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td><%= session.getAttribute("phone") %></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Masthead -->
    <header class="masthead bg-primary text-white text-center">
        <div class="container d-flex align-items-center flex-column">
            <!-- Masthead Avatar Image -->
            <img class="masthead-avatar mb-5" src="assets/img/avataaars.svg" alt="User Avatar" />
            <!-- Masthead Heading -->
            <h1 class="masthead-heading text-uppercase mb-0">Welcome To FortiNote</h1>
            <!-- Icon Divider -->
            <div class="divider-custom divider-light">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="divider-custom-line"></div>
            </div>
        </div>
    </header>

    <!-- Application Section -->
    <section id="app">
        <div class="container">
            <div class="row row-col-auto">
                <div class="col">
                    <div class="card" style="width: 20rem;">
                        <img src="images/notes_img.png" class="card-img-top" alt="Notes">
                        <div class="card-body">
                            <h5 class="card-title">Notes</h5>
                            <a href="Notes.jsp" class="btn btn-primary">Go Notes</a>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card" style="width: 20rem;">
                        <img src="images/todo-img.png" class="card-img-top" alt="Todo">
                        <div class="card-body">
                            <h5 class="card-title">Todo</h5>
                            <a href="Todo.jsp" class="btn btn-primary">Go Todo</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section class="page-section bg-primary text-white mb-0" id="about">
        <div class="container">
            <!-- About Section Heading -->
            <h2 class="page-section-heading text-center text-uppercase text-white">About</h2>
            <div class="divider-custom divider-light">
                <div class="divider-custom-line"></div>
                <div class="divider-custom-icon">
                    <i class="fas fa-star"></i>
                </div>
                <div class="divider-custom-line"></div>
            </div>
            <!-- About Section Content -->
            <div class="row">
                <div class="col-lg ms-auto">
                    <p class="lead">Our Mission<br/>
                        In a world where data privacy is paramount, our mission is to provide a secure, user-friendly platform for managing your notes. We believe that your thoughts and ideas deserve the highest level of protection, which is why we've designed this application with robust security features to keep your information safe.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer text-center">
        <div class="container">
            <div class="row">
                <!-- Footer Location -->
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <h4 class="text-uppercase mb-4">Location</h4>
                    <p class="lead mb-0">
                        VSB college of Engineering Technical Campus <br /> Coimbatore
                    </p>
                </div>
                <!-- Footer Social Icons -->
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <h4 class="text-uppercase mb-4">Around the Web</h4>
                    <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-facebook-f"></i></a>
                    <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-twitter"></i></a>
                    <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-linkedin-in"></i></a>
                    <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-dribbble"></i></a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Copyright Section -->
    <div class="copyright py-4 text-center text-white">
        <div class="container">
            <small>&copy; Your Website 2024</small>
        </div>
    </div>

    <!-- Bootstrap JS and other scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>
