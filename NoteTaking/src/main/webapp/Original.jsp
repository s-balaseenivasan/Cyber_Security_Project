<%@ page import="com.cyber.notetaking.Notes.AddNotes" %>
<%@ page import="com.cyber.notetaking.Model.Notes" %>
<%@ page import="com.cyber.notetaking.Model.User" %>
<%@ page import="com.cyber.notetaking.Util" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String noteIdStr = request.getParameter("noteId");
    if (noteIdStr == null || noteIdStr.isEmpty()) {
        session.setAttribute("error", "Note ID is missing.");
        response.sendRedirect("shownotes.jsp");
        return;
    }

    int noteid;
    try {
        noteid = Integer.parseInt(noteIdStr);
    } catch (NumberFormatException e) {
        session.setAttribute("error", "Invalid Note ID format.");
        response.sendRedirect("shownotes.jsp");
        return;
    }

    AddNotes an = new AddNotes();
    Notes notes = an.getNote(noteid);
    if (notes == null) {
        session.setAttribute("error", "Note not found.");
        response.sendRedirect("shownotes.jsp");
        return;
    }

    String decryptedContent = null;
    try {
        decryptedContent = Util.decrypt(notes.getContent(), user.getSecretKey());
    } catch (Exception e) {
        e.printStackTrace();
        decryptedContent = "Decryption failed.";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= user.getFname() %>'s Note</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="fontawesome/css/all.min.css">
    <link rel="stylesheet" href="css/notes.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
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
<nav class="navbar navbar-expand-lg bg-custom nav-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Notes App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
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
                <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="fa-solid fa-user"></i> <%= user.getFname() %></a>
            </form>
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
                <table class="table table-striped">
                    <tbody>
                        <tr><th>User Name</th><td><%= user.getFname() %> <%= user.getLname() %></td></tr>
                        <tr><th>Email</th><td><%= user.getEmail() %></td></tr>
                        <tr><th>Phone</th><td><%= user.getPhone() %></td></tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<main class="container mt-4">
    <h1 class="text-center mb-4 gradient-text">Original Text</h1>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title"><%= notes.getTitle() %></h5>
            <p class="card-text">
                <%= decryptedContent %>
            </p>
        </div>
    </div>
</main>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        var status = "<%= session.getAttribute("status") != null ? session.getAttribute("status") : "" %>";
        if (status === "failed") {
            swal("Error", "Note retrieval failed", "error");
        } else if (status === "success") {
            swal("Success", "Note retrieved successfully", "success");
        }
    });
</script>
<script type="text/javascript">
    document.addEventListener('copy', function(e) {
        e.preventDefault(); // Prevent copying
        e.clipboardData.setData('text/plain', "Copying is disabled.");
    });
</script>
</body>
</html>
