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
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f8f9fa;
            }
            .container {
                margin-top: 20px;
            }
            .table {
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2 class="text-center">Ticket History</h2>
            <%
                Customer customer = (Customer) session.getAttribute("customer");
                if (customer != null) {
                    int customerId = customer.getCustomerID();
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
                                     "WHERE b.CustomerID = ? OR b.BookingID = 1 " +
                                     "ORDER BY b.BookingID ASC";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setInt(1, customerId);
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
                            booking.setMovieTitle(rs.getString("Title"));
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
                        <td><%= booking.getMovieTitle() %></td>
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
        </div>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
