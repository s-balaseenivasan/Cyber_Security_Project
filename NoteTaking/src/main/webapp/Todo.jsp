<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.cyber.notetaking.Model.User" %>
<%@ page import="com.cyber.notetaking.Todo.TodoView" %>
<%@ page import="com.cyber.notetaking.Model.Todo" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        .rounded-table {
            border-radius: 10px;
            overflow: hidden;
        }
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
<nav class="navbar navbar-expand-lg fixed-top nav-custom bg-custom">

    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Todo App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="Todo.jsp"><i class="fa-solid fa-address-book"></i> Todo</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="TodoAdd.jsp"><i class="fa-solid fa-plus"></i> Add Todo</a>
                </li>
            </ul>
            <form class="d-flex">
                <a class="btn btn-danger me-2" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="fa-solid fa-user"></i> <%= user.getFname() %></a>
            </form>
        </div>
    </div>
</nav>

<!-- User Profile Modal -->
<div class="modal fade" id="profileModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="profileModalLabel">Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <tbody>
                        <tr>
                            <th>User Name</th>
                            <td><%= user.getFname() %> <%= user.getLname() %></td>
                        </tr>
                        <tr>
                            <th>Email</th>
                            <td><%= user.getEmail() %></td>
                        </tr>
                        <tr>
                            <th>Phone</th>
                            <td><%= user.getPhone() %></td>
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

<% 
    String umsg = (String) session.getAttribute("UMsg");
    if (umsg != null) { 
%>
    <div class="alert alert-success" role="alert"><%= umsg %></div>
<%
        session.removeAttribute("UMsg");
    }
    String emsg = (String) session.getAttribute("EMsg");
    if (emsg != null) { 
%>
    <div class="alert alert-danger" role="alert"><%= emsg %></div>
<%
        session.removeAttribute("EMsg");
    }
%>

<div class="container mt-4 pt-5">
    <h2 class="text-center mb-4 gradient-text">All Todo</h2>
    <div class="d-block d-sm-none text-center mb-3">
    <a href="TodoAdd.jsp" class="btn btn-primary">Add Todo</a>
    </div>
    <table class="table table-hover rounded-table">
        <thead>
            <tr>
                <th>S.No</th>
                <th>Task</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                TodoView todoView = new TodoView();
                List<Todo> todos = todoView.getData(user.getId());
                if (todos != null && !todos.isEmpty()) {
                    int count = 1;
                    for (Todo t : todos) {
            %>
            <tr>
                <td><%= count++ %></td>
                <td><%= t.getDescription() %></td>
                <td><%= t.getStatus() %></td>
                <td>
                    <a href="todo-delete?id=<%= t.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                    <a href="#" class="btn btn-secondary btn-sm ms-2" data-bs-toggle="modal" data-bs-target="#editTodoModal<%= t.getId() %>">Edit</a>
                </td>
            </tr>

            <!-- Edit Todo Modal -->
            <div class="modal fade" id="editTodoModal<%= t.getId() %>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="editTodoModalLabel<%= t.getId() %>" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editTodoModalLabel<%= t.getId() %>">Edit Todo</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="todo-update" method="post">
                                <input type="hidden" name="todoid" value="<%= t.getId() %>">
                                <div class="mb-3">
                                    <label for="description<%= t.getId() %>" class="form-label">Description</label>
                                    <input type="text" name="task" id="description<%= t.getId() %>" class="form-control" value="<%= t.getDescription() %>" required placeholder="Enter The Task">
                                </div>
                                <div class="mb-3">
                                    <label for="status<%= t.getId() %>" class="form-label">Status</label>
                                    <select name="status" id="status<%= t.getId() %>" class="form-select">
                                        <option value="Todo" <%= t.getStatus().equals("Todo") ? "selected" : "" %>>ToDo</option>
                                        <option value="Doing" <%= t.getStatus().equals("Doing") ? "selected" : "" %>>Doing</option>
                                        <option value="Done" <%= t.getStatus().equals("Done") ? "selected" : "" %>>Done</option>
                                    </select>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">Save</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <% 
                }
            } else { 
            %>
            <tr>
                <td colspan="4" class="text-center">No Todo available.</td>
            </tr>
            <% 
            } 
            %>
        </tbody>
    </table>
</div>

</body>
</html>
