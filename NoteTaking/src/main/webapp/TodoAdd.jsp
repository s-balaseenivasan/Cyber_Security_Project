<%@ page import="com.cyber.notetaking.Model.User" %>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return; // Ensure no further code is executed
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Todo</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/notes.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .gradient-text {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            display: flex;
            justify-content: center;
            margin: 0;
            font-size: 3em;
            font-weight: bold;
            background: linear-gradient(to right, #007aff, #7d3fe3, #fd2db2, #ff6200, #ff9500);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;

        }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-custom nav-custom">
    <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">Todo App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="Todo.jsp"><i class="fa-solid fa-address-book"></i> Todo</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="TodoAdd.jsp"><i class="fa-solid fa-plus"></i> Add Todo</a>
                </li>
            </ul>
            <div class="d-flex">
                <a class="btn btn-danger me-2" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="fa-solid fa-user"></i> <%=user.getFname()%></a>
            </div>
        </div>
    </div>
</nav>

<!-- Profile Modal -->
<div class="modal fade" id="profileModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="profileModalLabel">Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tbody>
                        <tr>
                            <th>User Name</th>
                            <td><%=user.getFname()%> <%=user.getLname()%></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%=user.getEmail()%></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td><%=user.getPhone()%></td>
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

<!-- Todo Form -->
<div class="container mt-4">
    <h2 class="mb-4 gradient-text">Add New Todo</h2>
    <form action="todo-add" method="post" id="todo-form">
        <div class="mb-3">
            <label for="description" class="form-label"><b> Task Description</b></label>
            <input type="text" name="task" id="description" class="form-control" required placeholder="Enter The Task" />
        </div>
        <div class="mb-3">
            <label for="status" class="form-label"><b> Status</b> </label>
            <select name="status" id="status" class="form-select">
                <option value="Todo">ToDo</option>
                <option value="Doing">Doing</option>
                <option value="Done">Done</option>
            </select>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary">Save</button>
        </div>
    </form>
</div>

</body>
</html>
