<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notes</title>
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-k6A6lq+3bYfp1FEcI8XW6LKTkRxg65sT8I0Rx4W4tPr45w47wv+lD3dZbcQnn7fi5qZDN2b9m7P/jGyMB0rUvg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<link rel="stylesheet" href="css/notes.css">
</head>
<body>
<nav class="navbar navbar-expand-lg bg-custom nav-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Notes App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="addnotes.jsp"><i class="fa-solid fa-plus"></i> Add Note</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="shownotes.jsp"><i class="fa-solid fa-address-book"></i> Show Note</a>
                </li>
            </ul>
            <form class="d-flex">
                <a class="btn btn-danger me-2" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop"><i class="fa-solid fa-user"></i> <%=session.getAttribute("fname")%></a>
            </form>
        </div>
    </div>
</nav>

<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="staticBackdropLabel">Profiles</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tbody>
                    <tr>
                        <th>User Name</th>
                        <td><%=session.getAttribute("fname")%> <%=session.getAttribute("lname")%></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><%=session.getAttribute("email")%></td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td><%=session.getAttribute("phone")%></td>
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

<div class="container-fluid">
    <div class="card py-5 text-center">
        <div class="card-body">
            <img src="images/notes.png" class="img-fluid mx-auto" style="max-width: 300px;" alt="Notes">
            <h1>Start Taking Your Notes</h1>
            <a href="addnotes.jsp" class="btn btn-outline-primary">Start Here</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
