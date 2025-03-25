package model;

import java.util.Date;

public class Booking {
    private int BookingID;
    private int CustomerID;
    private Date BookingDate;
    private double TotalPrice;

    // Constructor
    
    public Booking() {
    }

    public Booking(int bookingID, int customerID, Date bookingDate, double totalPrice) {
        this.BookingID = bookingID;
        this.CustomerID = customerID;
        this.BookingDate = bookingDate;
        this.TotalPrice = totalPrice;
    }

    // Getters and Setters
    public int getBookingID() {
        return BookingID;
    }

    public void setBookingID(int bookingID) {
        this.BookingID = bookingID;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int customerID) {
        this.CustomerID = customerID;
    }

    public Date getBookingDate() {
        return BookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.BookingDate = bookingDate;
    }

    public double getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.TotalPrice = totalPrice;
    }
}
