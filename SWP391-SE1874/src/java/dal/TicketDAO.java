/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Ticket;
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
public class TicketDAO extends DBContext{
    public void saveTicket(Ticket ticket) throws Exception {
        try (Connection conn = getConnection()) {
            String sql = "INSERT INTO Ticket (BookingID, ShowtimeID, SeatID, Price) VALUES (?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, ticket.getBookingId());
            stmt.setInt(2, ticket.getShowtimeId());
            stmt.setInt(3, ticket.getSeatId());
            stmt.setDouble(4, ticket.getPrice());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Ticket> getTicketsByCustomerId(int customerId) throws Exception {
        List<Ticket> tickets = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT t.TicketID, t.BookingID, t.ShowtimeID, t.SeatID, t.Price " +
                         "FROM Ticket t " +
                         "JOIN Booking b ON t.BookingID = b.BookingID " +
                         "WHERE b.CustomerID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setTicketId(rs.getInt("TicketID"));
                ticket.setBookingId(rs.getInt("BookingID"));
                ticket.setShowtimeId(rs.getInt("ShowtimeID"));
                ticket.setSeatId(rs.getInt("SeatID"));
                ticket.setPrice(rs.getDouble("Price"));
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public List<Ticket> getTicketsByBookingId(int bookingId) throws Exception {
        List<Ticket> tickets = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT TicketID, BookingID, ShowtimeID, SeatID, Price FROM Ticket WHERE BookingID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setTicketId(rs.getInt("TicketID"));
                ticket.setBookingId(rs.getInt("BookingID"));
                ticket.setShowtimeId(rs.getInt("ShowtimeID"));
                ticket.setSeatId(rs.getInt("SeatID"));
                ticket.setPrice(rs.getDouble("Price"));
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }
}
