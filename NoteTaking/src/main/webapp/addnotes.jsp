<%@ page import="com.cyber.notetaking.Model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Notes</title>
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
        .hidden {
            display: none;
        }
    </style>
    <script src="js/jquery-3.7.1.min.js"></script>
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

<div class="container mt-5">
    <form action="add-notes" method="post" class="card">
        <h1 class="text-center mb-4 gradient-text">Add Your Notes</h1>
        <div class="mb-3">
            <label for="title" class="form-label"><b>Notes Title</b> </label>
            <input type="text" class="form-control" id="title" name="title" required placeholder="Title">
        </div>
        <div class="mb-3">
            <label for="Content" class="form-label"><b>Enter Content</b>  </label>
            <textarea class="form-control" id="Content" name="content" required rows="10"></textarea>
        </div>
        <div class="text-center">
            <button type="button" id="start-btn" class="btn btn-danger">Speak</button>
            <button type="button" id="stop-btn" class="btn btn-secondary hidden">Stop</button>
            <p id="instruction">Tap to Speak</p>
            <button type="submit" class="btn btn-primary">Add Notes</button>
        </div>
    </form>
</div>

<input type="hidden" id="status" value="<%=request.getAttribute("status")%>">
<%
    User user = (User)request.getSession().getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    session.setAttribute("uid", user.getId());
    session.setAttribute("user", user);
%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        var status = document.getElementById("status").value;
        if (status === "failed") {
            swal("Sorry", "Notes not added. Something went wrong.", "error");
        }
        if (status === "success") {
            swal("Success", "Notes added successfully.", "success");
        }
    });

    document.addEventListener('copy', function(e) {
        e.clipboardData.setData('text/plain', "Can't be copied");
        e.preventDefault(); // Prevent copying
    });

    // Speech recognition setup
    var SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
    var recognition = new SpeechRecognition();
    var textbox = $("#Content");
    var instruction = $("#instruction");
    var startBtn = $("#start-btn");
    var stopBtn = $("#stop-btn");

    var content = '';

    recognition.continuous = true;

    recognition.onstart = function () {
        instruction.text("Voice Recognition is On");
        startBtn.addClass('hidden');
        stopBtn.removeClass('hidden');
    };

    recognition.onspeechend = function () {
        instruction.text("No Activity");
    };

    recognition.onerror = function (event) {
        instruction.text("Try Again: " + event.error);
    };

    recognition.onresult = function (event) {
        var current = event.resultIndex;
        var transcript = event.results[current][0].transcript;

        content += transcript;
        textbox.val(content);
    };

    startBtn.click(function () {
        recognition.start();
    });

    stopBtn.click(function () {
        recognition.stop();
        instruction.text("Voice Recognition is Off");
        startBtn.removeClass('hidden');
        stopBtn.addClass('hidden');
    });

    textbox.on("input", function () {
        content = $(this).val(); // Update content variable with user input
    });
</script>
</body>
</html>
