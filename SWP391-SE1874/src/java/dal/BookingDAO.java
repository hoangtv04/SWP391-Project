package dal;

import model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class BookingDAO extends DBContext {
    public void saveBooking(Booking booking) throws Exception {
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO Booking (CustomerID, BookingDate, TotalPrice, ScreenID, SeatID, ShowtimeID, VoucherID) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, booking.getCustomerId());
            stmt.setTimestamp(2, new java.sql.Timestamp(booking.getBookingDate().getTime()));
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
            throw new Exception("Error saving booking", e);
        }
    }

    public List<Booking> getBookingsByCustomerId(int customerId) throws Exception {
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT b.BookingID, b.BookingDate, b.TotalPrice, s.ScreenName, se.SeatNumber, sh.StartTime, v.Code AS VoucherCode " +
                         "FROM Booking b " +
                         "LEFT JOIN Screen s ON b.ScreenID = s.ScreenID " +
                         "LEFT JOIN Seat se ON b.SeatID = se.SeatID " +
                         "LEFT JOIN Showtime sh ON b.ShowtimeID = sh.ShowtimeID " +
                         "LEFT JOIN Voucher v ON b.VoucherID = v.VoucherID " +
                         "WHERE b.CustomerID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("BookingID"));
                booking.setBookingDate(rs.getDate("BookingDate"));
                booking.setTotalPrice(rs.getDouble("TotalPrice"));
                booking.setScreenName(rs.getString("ScreenName"));
                booking.setSeatNumber(rs.getString("SeatNumber"));
                booking.setStartTime(rs.getTimestamp("StartTime"));
                booking.setVoucherCode(rs.getString("VoucherCode"));
                bookings.add(booking);
            }
            rs.close();
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
    // Method to get all bookings
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String query = "SELECT b.BookingID, b.BookingDate, b.TotalPrice, " +
                       "s.ScreenName, st.SeatNumber, sh.StartTime, " +
                       "v.Code AS VoucherCode, c.CustomerName, m.Title AS MovieTitle " + // Corrected column names
                       "FROM Booking b " +
                       "JOIN Screen s ON b.ScreenID = s.ScreenID " +
                       "JOIN Seat st ON b.SeatID = st.SeatID " +
                       "JOIN Showtime sh ON b.ShowtimeID = sh.ShowtimeID " +
                       "JOIN Voucher v ON b.VoucherID = v.VoucherID " +
                       "JOIN Customer c ON b.CustomerID = c.CustomerID " +
                       "JOIN Movie m ON b.MovieID = m.MovieID";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("BookingID"));
                booking.setBookingDate(rs.getDate("BookingDate"));
                booking.setTotalPrice(rs.getDouble("TotalPrice"));
                booking.setScreenName(rs.getString("ScreenName"));
                booking.setSeatNumber(rs.getString("SeatNumber"));
                booking.setStartTime(rs.getTimestamp("StartTime"));
                booking.setVoucherCode(rs.getString("VoucherCode"));
                booking.setCustomerName(rs.getString("CustomerName"));
                booking.setTitle(rs.getString("MovieTitle"));
                bookings.add(booking);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, "Error fetching all bookings", ex);
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bookings;
    }

    // Method to get a booking by ID
    public Booking getBookingById(int id) {
        String query = "SELECT * FROM Booking WHERE BookingID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getInt("BookingID"));
                    booking.setCustomerId(rs.getInt("CustomerID"));
                    booking.setBookingDate(rs.getDate("BookingDate"));
                    booking.setTotalPrice(rs.getDouble("TotalPrice"));
                    booking.setScreenId(rs.getInt("ScreenID"));
                    booking.setSeatId(rs.getInt("SeatID"));
                    booking.setShowtimeId(rs.getInt("ShowtimeID"));
                    booking.setVoucherId(rs.getInt("VoucherID"));
                    return booking;
                }
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, "Error fetching booking by ID", ex);
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Method to add a new booking
    public boolean addBooking(Booking booking) {
        String query = "INSERT INTO Booking (CustomerID, BookingDate, TotalPrice, ScreenID, SeatID, ShowtimeID, VoucherID) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, booking.getCustomerId());
            stmt.setDate(2, new java.sql.Date(booking.getBookingDate().getTime()));
            stmt.setDouble(3, booking.getTotalPrice());
            stmt.setInt(4, booking.getScreenId());
            stmt.setInt(5, booking.getSeatId());
            stmt.setInt(6, booking.getShowtimeId());
            stmt.setInt(7, booking.getVoucherId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, "Error adding booking", ex);
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Method to update a booking
    public boolean updateBooking(Booking booking) {
        String query = "UPDATE Booking SET CustomerID = ?, BookingDate = ?, TotalPrice = ?, ScreenID = ?, SeatID = ?, ShowtimeID = ?, VoucherID = ? WHERE BookingID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, booking.getCustomerId());
            stmt.setDate(2, new java.sql.Date(booking.getBookingDate().getTime()));
            stmt.setDouble(3, booking.getTotalPrice());
            stmt.setInt(4, booking.getScreenId());
            stmt.setInt(5, booking.getSeatId());
            stmt.setInt(6, booking.getShowtimeId());
            stmt.setInt(7, booking.getVoucherId());
            stmt.setInt(8, booking.getBookingId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, "Error updating booking", ex);
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Method to delete a booking
    public boolean deleteBooking(int id) {
        String query = "DELETE FROM Booking WHERE BookingID = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, "Error deleting booking", ex);
        } catch (Exception ex) {
            Logger.getLogger(BookingDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}