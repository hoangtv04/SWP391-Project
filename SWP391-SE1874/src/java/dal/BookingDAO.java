/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Booking;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author tovie
 */
public class BookingDAO extends DBContext{
    public void saveBooking(Booking booking) throws Exception {
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO Booking (CustomerID, BookingDate, TotalPrice, ScreenID, SeatID, ShowtimeID, VoucherID) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, booking.getCustomerId());
            stmt.setDate(2, new java.sql.Date(booking.getBookingDate().getTime()));
            stmt.setDouble(3, booking.getTotalPrice());
            stmt.setInt(4, booking.getScreenId());
            stmt.setInt(5, booking.getSeatId());
            stmt.setInt(6, booking.getShowtimeId());
            stmt.setInt(7, booking.getVoucherId());
            stmt.executeUpdate();
            // Get generated booking ID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    booking.setBookingId(generatedKeys.getInt(1));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Booking> getBookingsByCustomerId(int customerId) throws Exception {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT BookingID, CustomerID, BookingDate, TotalPrice, ScreenID, SeatID, ShowtimeID, VoucherID FROM Booking WHERE CustomerID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("BookingID"));
                booking.setCustomerId(rs.getInt("CustomerID"));
                booking.setBookingDate(rs.getDate("BookingDate"));
                booking.setTotalPrice(rs.getDouble("TotalPrice"));
                booking.setScreenId(rs.getInt("ScreenID"));
                booking.setSeatId(rs.getInt("SeatID"));
                booking.setShowtimeId(rs.getInt("ShowtimeID"));
                booking.setVoucherId(rs.getInt("VoucherID"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
}
