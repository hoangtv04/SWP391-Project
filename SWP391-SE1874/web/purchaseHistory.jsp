<%-- 
    Document   : purchaseHistory
    Created on : Mar 25, 2025, 5:01:59 PM
    Author     : tovie
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="dal.DBContext"%>
<%@page import="model.Booking"%>
<%@page import="model.Customer"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ticket History</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                background: url('image member/member.jpg') no-repeat center center fixed;
                background-size: cover;
                color: #333;
            }
            .container {
                margin-top: 20px;
                background-color: rgba(255, 255, 255, 0.9);
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            .table {
                margin-top: 20px;
            }
            .back-button {
                margin-top: 20px;
                display: block;
                width: 100%;
                text-align: center;
            }
            .text-center {
                margin-bottom: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Ticket History</h2>
            <%
                Customer customer = (Customer) session.getAttribute("customer");
                if (customer != null) {
                    List<Booking> bookings = null;

                    try {
                        DBContext dbContext = new DBContext();
                        Connection conn = dbContext.getConnection();
                        String sql = "SELECT b.BookingID, b.BookingDate, b.TotalPrice, s.ScreenName, se.SeatNumber, sh.StartTime, v.Code, c.CustomerName, m.Title " +
                                     "FROM Booking b " +
                                     "LEFT JOIN Screen s ON b.ScreenID = s.ScreenID " +
                                     "LEFT JOIN Seat se ON b.SeatID = se.SeatID " +
                                     "LEFT JOIN Showtime sh ON b.ShowtimeID = sh.ShowtimeID " +
                                     "LEFT JOIN Voucher v ON b.VoucherID = v.VoucherID " +
                                     "LEFT JOIN Customer c ON b.CustomerID = c.CustomerID " +
                                     "LEFT JOIN Movie m ON sh.MovieID = m.MovieID " +
                                     "ORDER BY b.BookingID ASC";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();

                        bookings = new ArrayList<>();
                        while (rs.next()) {
                            Booking booking = new Booking();
                            booking.setBookingId(rs.getInt("BookingID"));
                            booking.setBookingDate(rs.getDate("BookingDate"));
                            booking.setTotalPrice(rs.getDouble("TotalPrice"));
                            booking.setScreenName(rs.getString("ScreenName"));
                            booking.setSeatNumber(rs.getString("SeatNumber"));
                            booking.setStartTime(rs.getTimestamp("StartTime"));
                            booking.setVoucherCode(rs.getString("Code"));
                            booking.setCustomerName(rs.getString("CustomerName"));
                            booking.setTitle(rs.getString("Title")); // Corrected method name
                            bookings.add(booking);
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    if (bookings != null && !bookings.isEmpty()) {
            %>
            <table class="table table-bordered">
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
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Booking booking : bookings) {
                    %>
                    <tr>
                        <td><%= booking.getBookingId() %></td>
                        <td><%= booking.getBookingDate() %></td>
                        <td><%= booking.getTotalPrice() %></td>
                        <td><%= booking.getScreenName() %></td>
                        <td><%= booking.getSeatNumber() %></td>
                        <td><%= booking.getStartTime() %></td>
                        <td><%= booking.getVoucherCode() %></td>
                        <td><%= booking.getCustomerName() %></td>
                        <td><%= booking.getTitle() %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <%
                    } else {
            %>
            <p class="text-center">No ticket history available.</p>
            <%
                    }
                } else {
            %>
            <p class="text-center">Please log in to view your ticket history.</p>
            <%
                }
            %>
            <a href="movie" class="btn btn-primary back-button">Back to Home</a>
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
