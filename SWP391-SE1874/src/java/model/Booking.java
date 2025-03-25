/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class Booking {
    private int bookingId;
    private int customerId;
    private Date bookingDate;
    private double totalPrice;
    private int screenId;
    private int seatId;
    private int showtimeId;
    private int voucherId;

    // Default constructor
    public Booking() {
    }

    // Parameterized constructor
    public Booking(int bookingId, int customerId, Date bookingDate, double totalPrice, int screenId, int seatId, int showtimeId, int voucherId) {
        this.bookingId = bookingId;
        this.customerId = customerId;
        this.bookingDate = bookingDate;
        this.totalPrice = totalPrice;
        this.screenId = screenId;
        this.seatId = seatId;
        this.showtimeId = showtimeId;
        this.voucherId = voucherId;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getScreenId() {
        return screenId;
    }

    public void setScreenId(int screenId) {
        this.screenId = screenId;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }
}
