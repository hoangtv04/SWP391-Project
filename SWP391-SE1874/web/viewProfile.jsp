<%-- 
    Document   : viewProfile
    Created on : Mar 26, 2025, 2:29:20 AM
    Author     : tovie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Customer"%>
<%
    Customer customer = (Customer) session.getAttribute("customer");
    if (customer == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String successMessage = (String) request.getAttribute("successMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Profile</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('image member/member.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
        }
        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Increased opacity for better contrast */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Added shadow for depth */
        }
        .form-group input {
            transition: all 0.3s ease; /* Smooth transition for hover effect */
        }
        .form-group input:hover {
            transform: scale(1.02); /* Slightly enlarge the input field on hover */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Add shadow on hover */
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center">View Profile</h2>
        <% if (successMessage != null) { %>
            <div class="alert alert-success" role="alert">
                <%= successMessage %>
            </div>
        <% } %>
        <form action="updateprofile" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="customerName">Name:</label>
                <input type="text" class="form-control" id="customerName" name="customerName" value="<%= customer.getCustomerName() %>" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= customer.getEmail() %>" required>
                <div id="emailError" class="text-danger"></div>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= customer.getPhone() %>" required>
                <div id="phoneError" class="text-danger"></div>
            </div>
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" class="form-control" id="address" name="address" value="<%= customer.getAddress() %>" required>
                <div id="addressError" class="text-danger"></div>
            </div>
            <button type="submit" class="btn btn-primary">Update Profile</button>
            <a href="movie" class="btn btn-secondary">Back to Home</a>
        </form>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function validateForm() {
            var email = document.getElementById("email").value;
            var phone = document.getElementById("phone").value;
            var address = document.getElementById("address").value;

            var emailError = document.getElementById("emailError");
            var phoneError = document.getElementById("phoneError");
            var addressError = document.getElementById("addressError");

            var isValid = true;

            var emailPattern = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
            if (!emailPattern.test(email)) {
                emailError.textContent = "Email must be a valid Gmail address.";
                isValid = false;
            } else {
                emailError.textContent = "";
            }

            if (phone.length > 10) {
                phoneError.textContent = "Phone number must be at most 10 digits.";
                isValid = false;
            } else {
                phoneError.textContent = "";
            }

            if (address.length > 100) {
                addressError.textContent = "Address must be at most 100 characters.";
                isValid = false;
            } else {
                addressError.textContent = "";
            }

            return isValid;
        }
    </script>
</body>
</html>
