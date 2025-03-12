package com.megacab.booking;
 
 public class Booking {
     private int id;
     private String userName;
     private String pickupLocation;
     private String dropoffLocation;
     private String vehicleType;
     private double distance;
     private String bookedDate;
     private double fare; 
     private String driverName; // Add the driverName field
 
     // Default constructor
     public Booking() {}
 
     // Parameterized constructor
     public Booking(int id, String userName, String pickupLocation, String dropoffLocation, String vehicleType, double distance, String bookedDate, double fare) {
         this.id = id;
         this.userName = userName;
         this.pickupLocation = pickupLocation;
         this.dropoffLocation = dropoffLocation;
         this.vehicleType = vehicleType;
         this.distance = distance;
         this.bookedDate = bookedDate;
         this.fare = fare;
     }
 
     // Getters
     public int getId() { return id; }
     public String getUserName() { return userName; }
     public String getPickupLocation() { return pickupLocation; }
     public String getDropoffLocation() { return dropoffLocation; }
     public String getVehicleType() { return vehicleType; }
     public double getDistance() { return distance; }
     public String getBookedDate() { return bookedDate; }
     public double getFare() { return fare; } 
     public String getDriverName() {
         return driverName; // Getter for driverName
     }

 
     // Setters
     public void setId(int id) { this.id = id; }
     public void setUserName(String userName) { this.userName = userName; }
     public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }
     public void setDropoffLocation(String dropoffLocation) { this.dropoffLocation = dropoffLocation; }
     public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
     public void setDistance(double distance) { this.distance = distance; }
     public void setBookedDate(String bookedDate) { this.bookedDate = bookedDate; }
     public void setFare(double fare) { this.fare = fare; }
     public void setDriverName(String driverName) {
         this.driverName = driverName; // Setter for driverName
     }
 }