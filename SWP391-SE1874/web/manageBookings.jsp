<%-- 
    Document   : manageBookings
    Created on : 25 thg 3, 2025, 11:13:35
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Booking"%>
<%@page import="model.Admin"%>
<%@page import="dal.BookingDAO"%> <!-- Ensure this matches the actual package of BookingDAO -->
<%@page import="java.lang.reflect.Field"%>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    int adminID = 0;
    try {
        Field field = admin.getClass().getDeclaredField("adminId");
        field.setAccessible(true);
        adminID = field.getInt(admin);
    } catch (Exception e) {
        e.printStackTrace();
    }

    BookingDAO bookingDAO = new BookingDAO(); // Ensure BookingDAO is correctly imported and instantiated
    List<Booking> bookings = null;
    try {
        // Replace the method call with an appropriate method from BookingDAO
        bookings = bookingDAO.getAllBookings(); // Example: Use getAllBookings() if it exists
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Manage Bookings</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .header {
                background-color: #2980b9;
                color: white;
                padding: 10px 0;
                text-align: center;
                position: relative;
            }
            .logout-btn {
                position: absolute;
                top: 10px;
                right: 20px;
                background-color: #333;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 5px;
            }
            .logout-btn:hover {
                background-color: #ddd;
                color: black;
            }
            .navbar {
                overflow: hidden;
                background-color: #333;
                display: flex;
                justify-content: center;
            }
            .navbar a {
                float: left;
                display: block;
                color: white;
                text-align: center;
                padding: 14px 20px;
                text-decoration: none;
            }
            .navbar a:hover {
                background-color: #ddd;
                color: black;
            }

            .container {
                padding: 20px;
            }
            .table-container {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            table, th, td {
                border: 1px solid #ddd;
            }
            th, td {
                padding: 10px;
                text-align: center;
            }
            th {
                background-color: #2980b9;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            .header p {
                text-align: left;
                margin-left: 20px;
            }
        </style>
        <script>
            function confirmDelete(bookingID) {
                if (confirm('Are you sure you want to delete this booking?')) {
                    document.getElementById('deleteForm-' + bookingID).submit();
                }
            }
        </script>
    </head>
    <body>
        <div class="header">
            <h1>Admin Dashboard - Manage Bookings</h1>
            <p>Xin chào, <%= admin.getName() %>!</p>
            <a href="logout" class="logout-btn">Đăng xuất</a>
        </div>

        <div class="navbar">
            <a href="AdminDashboard">Home</a>
            <a href="user">Manage Users</a>
            <a href="Movies">Manage Movies</a>
            <a href="Showtime">Manage Showtimes</a>
            <a href="manageBookings.jsp">Manage Bookings</a>
            <a href="reviews">Manage Reviews</a>
            <a href="voucher">Manage Vouchers</a>
        </div>

        <div class="container">
            <div class="table-container">
                <h2 class="text-center">Danh sách đặt chỗ</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Booking Date</th>
                            <th>Total Price</th>
                            <th>Screen Name</th>
                            <th>Seat Number</th>
                            <th>Start Time</th>
                            <th>Voucher Code</th>
                            <th>Customer Name</th>
                            <th>Movie Title</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (bookings != null && !bookings.isEmpty()) {
                               for (Booking booking : bookings) { %>
                        <tr>
                            <td><%= booking.getBookingId() %></td> <!-- Corrected method name -->
                            <td><%= booking.getBookingDate() %></td>
                            <td><%= booking.getTotalPrice() %></td>
                            <td><%= booking.getScreenName() %></td>
                            <td><%= booking.getSeatNumber() %></td>
                            <td><%= booking.getStartTime() %></td>
                            <td><%= booking.getVoucherCode() %></td>
                            <td><%= booking.getCustomerName() %></td>
                            <td><%= booking.getTitle() %></td> <!-- Corrected method name -->
                            <td>
                                <form id="deleteForm-<%= booking.getBookingId() %>" action="booking" method="post" style="display:inline;"> <!-- Corrected method name -->
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="bookingID" value="<%= booking.getBookingId() %>"> <!-- Corrected method name -->
                                    <button type="button" class="delete-btn" onclick="confirmDelete('<%= booking.getBookingId() %>')">Delete</button> <!-- Corrected method name -->
                                </form>
                            </td>
                        </tr>
                        <% } } else { %>
                        <tr>
                            <td colspan="10">Không có đặt chỗ nào.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
