<%@ page import="jakarta.mail.Session" %>
<%@ page import="com.cyber.notetaking.Model.User" %>
<%@ page import="com.cyber.notetaking.Notes.AddNotes" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cyber.notetaking.Model.Notes" %>
<%@ page import="com.cyber.notetaking.Util" %>
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
    <title>Show Notes</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-k6A6lq+3bYfp1FEcI8XW6LKTkRxg65sT8I0Rx4W4tPr45w47wv+lD3dZbcQnn7fi5qZDN2b9m7P/jGyMB0rUvg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/notes.css">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
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
<nav class="navbar navbar-expand-lg  fixed-top nav-custom bg-custom">
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
                    <a class="nav-link active" href="shownotes.jsp"><i class="fa-solid fa-address-book"></i> Show Note</a>
                </li>
            </ul>
            <form class="d-flex">
                <a class="btn btn-danger me-2" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="fa-solid fa-user"></i> <%=session.getAttribute("fname")%></a>
            </form>
        </div>
    </div>
</nav>

<div class="modal fade" id="profileModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="profileModalLabel" aria-hidden="true">
    <div class="modal-dialog">
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

<% 
    String updateMessage = (String) session.getAttribute("UMsg");
    String errorMessage = (String) session.getAttribute("EMsg");
    String error = (String) session.getAttribute("error");
    session.removeAttribute("error");
    session.removeAttribute("UMsg");
    session.removeAttribute("EMsg");
%>

<% if (updateMessage != null || errorMessage != null || error != null) { %>
    <div class="container mt-4 pt-5">
        <div class="alert alert-<%= errorMessage != null ? "danger" : "success" %>" role="alert">
            <%= updateMessage != null ? updateMessage : (errorMessage != null ? errorMessage : error) %>
        </div>
    </div>
<% } %>
<div class="container mt-4 pt-5">
    <h2 class="text-center gradient-text">All Notes</h2>
    <div class="d-block d-sm-none text-center mb-3">
    <a href="addnotes.jsp" class="btn btn-primary">Add Note</a>
</div>
    <div class="row">
        <div class="col-md-12">
            <%
                AddNotes an = new AddNotes();
                List<Notes> notes = an.getData(user.getId());
                if (notes != null && !notes.isEmpty()) {
                    for (Notes n : notes) {
            %>
            <div class="card mt-3 card-custom">
                <img src="images/notes.png" class="card-img-top mt-2 mx-auto" style="max-width:100px;" alt="Note Image">
                <div class="card-body p-4">
                    <h5 class="card-title">Title: <%= n.getTitle() %></h5>
                    <p><%=n.getContent()%></p>
                    <p>
                        <b class="text-dark">Published By:</b><br>
                        <b class="text-primary"><%= user.getFname() %></b>
                    </p>
                    <p>
                        <b class="text-dark">Published Date:</b><br>
                        <b class="text-primary"><%= n.getTimestamp() %></b>
                    </p>
                    <div class="d-flex justify-content-center mt-2">
                        <a href="#" class="btn btn-success me-2" data-bs-toggle="modal" data-bs-target="#noteModal<%=n.getId()%>">Decrypt</a>
                        <a href="delete?noteid=<%=n.getId()%>" class="btn btn-danger me-2" onclick="return confirm('Are you sure you want to delete this note?');">Delete</a>
                        <a href="#" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#noteModal1<%=n.getId()%>">Edit</a>
                    </div>
                </div>
            </div>

            <!-- Decrypt Modal -->
            <div class="modal fade" id="noteModal<%=n.getId()%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="noteModalLabel<%=n.getId()%>" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="noteModalLabel<%=n.getId()%>">Decrypt Note</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="original" method="post">
                                <input type="hidden" name="noteId" value="<%=n.getId()%>">
                                <div class="mb-3">
                                    <label for="email<%=n.getId()%>" class="form-label">Email</label>
                                    <input type="email" name="email" id="email<%=n.getId()%>" class="form-control" required placeholder="Enter The Email">
                                </div>
                                <div class="mb-3">
                                    <label for="password<%=n.getId()%>" class="form-label">Password</label>
                                    <input type="password" name="password" id="password<%=n.getId()%>" class="form-control" required placeholder="Password">
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-secondary">Submit</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Modal -->
            <div class="modal fade" id="noteModal1<%=n.getId()%>" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="noteModalLabel<%=n.getId()%>" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="noteModalLabel<%=n.getId()%>">Edit Note</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="note-edit" method="post">
                                <input type="hidden" name="noteId" value="<%=n.getId()%>">
                                <div class="mb-3">
                                    <label for="email1<%=n.getId()%>" class="form-label">Email</label>
                                    <input type="email" name="email" id="email1<%=n.getId()%>" class="form-control" required placeholder="Enter The Email">
                                </div>
                                <div class="mb-3">
                                    <label for="password1<%=n.getId()%>" class="form-label">Password</label>
                                    <input type="password" name="password" id="password1<%=n.getId()%>" class="form-control" required placeholder="Password">
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-secondary">Submit</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
        <% } else { %>
            <p class="text-center">No notes available.</p>
        <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script type="text/javascript">
    document.addEventListener('copy', function(e) {
        e.preventDefault(); // Prevent copying
        e.clipboardData.setData('text/plain', "Can't be copied");
    });
</script>
</body>
</html>
