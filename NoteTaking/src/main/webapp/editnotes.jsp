<%@ page import="com.cyber.notetaking.Model.User" %>
<%@ page import="com.cyber.notetaking.Model.Notes" %>
<%@ page import="com.cyber.notetaking.Notes.AddNotes" %>
<%@ page import="com.cyber.notetaking.Util" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Notes</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <!-- FontAwesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" integrity="sha512-k6A6lq+3bYfp1FEcI8XW6LKTkRxg65sT8I0Rx4W4tPr45w47wv+lD3dZbcQnn7fi5qZDN2b9m7P/jGyMB0rUvg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/notes.css">
    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://unpkg.com/sweetalert/dist/sweetalert.css">
    <!-- JavaScript Libraries -->
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
<%
    User user = (User) request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer noteid = null;
    try {
        noteid = Integer.parseInt(request.getParameter("noteid"));
    } catch (NumberFormatException e) {
        response.sendRedirect("shownotes.jsp?status=invalidNoteId");
        return;
    }

    AddNotes an = new AddNotes();
    Notes notes = an.getNote(noteid); // Handle possible null value
    if (notes == null) {
        response.sendRedirect("shownotes.jsp?status=noteNotFound");
        return;
    }
%>
<nav class="navbar navbar-expand-lg navbar-light bg-custom">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">Notes App</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="addnotes.jsp"><i class="fa-solid fa-plus"></i> Add Note</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="shownotes.jsp"><i class="fa-solid fa-address-book"></i> Show Note</a>
                </li>
            </ul>
            <form class="d-flex ms-auto">
                <a class="btn btn-danger me-2" href="logout"><i class="fa-solid fa-circle-left"></i> Logout</a>
                <a class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#profileModal"><i class="fa-solid fa-user"></i> <%= session.getAttribute("fname") %></a>
            </form>
        </div>
    </div>
</nav>

<!-- Profile Modal -->
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

<div class="container mt-4">
    <h1 class="text-center gradient-text">Edit Your Notes</h1>
    <form action="update_note" method="post">
        <input type="hidden" name="noteid" value="<%= noteid %>">
        <div class="mb-3">
            <label for="noteTitle" class="form-label">Notes Title</label>
            <input type="text" class="form-control" id="noteTitle" name="title" placeholder="Title" value="<%= notes.getTitle() %>" required>
        </div>
        <div class="mb-3">
            <label for="Content" class="form-label">Enter Content</label>
            <%
                String decryptContent = "";
                try {
                    decryptContent = Util.decrypt(notes.getContent(), user.getSecretKey());
                } catch (Exception e) {
                    decryptContent = "Error decrypting content";
                    e.printStackTrace();
                }
            %>
            <textarea class="form-control" id="Content" name="content" rows="10" required><%= decryptContent %></textarea>
        </div>
        <div class="text-center">
            <button type="button" id="start-btn" class="btn btn-danger">Speak</button>
            <button type="button" id="stop-btn" class="btn btn-secondary d-none">Stop</button>
            <p id="instruction">Tap to Speak</p>
            <button type="submit" class="btn btn-primary">Update Notes</button>
        </div>
    </form>
</div>

<%
    String status = request.getParameter("status");
%>
<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        var status = "<%= status != null ? status : "" %>";
        if (status === "failed") {
            swal("Error", "Notes not updated due to an error", "error");
        } else if (status === "success") {
            swal("Success", "Notes updated successfully", "success");
        } else if (status === "invalidNoteId") {
            swal("Error", "Invalid note ID", "error");
        } else if (status === "noteNotFound") {
            swal("Error", "Note not found", "error");
        }
    });
</script>
<script type="text/javascript">
    // Speech recognition setup
    var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    var recognition = new SpeechRecognition();
    var textbox = document.getElementById("Content");
    var instruction = document.getElementById("instruction");
    var startBtn = document.getElementById("start-btn");
    var stopBtn = document.getElementById("stop-btn");

    var content = '';

    recognition.continuous = true;

    recognition.onstart = function () {
        instruction.textContent = "Voice Recognition is On";
        startBtn.classList.add('d-none');
        stopBtn.classList.remove('d-none');
    };

    recognition.onspeechend = function () {
        instruction.textContent = "No Activity";
    };

    recognition.onerror = function (event) {
        instruction.textContent = "Try Again: " + event.error;
    };

    recognition.onresult = function (event) {
        var current = event.resultIndex;
        var transcript = event.results[current][0].transcript;

        content += transcript;
        textbox.value = content;
    };

    startBtn.addEventListener('click', function () {
        recognition.start();
    });

    stopBtn.addEventListener('click', function () {
        recognition.stop();
        instruction.textContent = "Voice Recognition is Off";
        startBtn.classList.remove('d-none');
        stopBtn.classList.add('d-none');
    });

    textbox.addEventListener("input", function () {
        content = textbox.value;
    });
</script>
<script type="text/javascript">
    document.addEventListener('copy', function(e) {
        e.preventDefault(); // Prevent copying
        e.clipboardData.setData('text/plain', "Can't be copied");
    });
</script>
</body>
</html>
