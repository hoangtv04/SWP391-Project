/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author tovie
 */
public class Ticket {
    private int ticketId;
    private int bookingId;
    private int showtimeId;
    private int seatId;
    private double price;

    // Default constructor
    public Ticket() {
    }

    // Parameterized constructor
    public Ticket(int ticketId, int bookingId, int showtimeId, int seatId, double price) {
        this.ticketId = ticketId;
        this.bookingId = bookingId;
        this.showtimeId = showtimeId;
        this.seatId = seatId;
        this.price = price;
    }

    // Getters and Setters
    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
