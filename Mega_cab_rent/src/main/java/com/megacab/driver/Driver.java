package com.megacab.driver;

public class Driver {
    private int id;
    private String name;
    private String password;
    private String email;
    private String mobile;
    private String nic;
    private String vehicle;
    private String vehicle_type;


    // Default constructor
    public Driver() {}

    // Parameterized constructor
    public Driver(int id, String name, String password, String email, String mobile, String nic, String vehicle, String vehicle_type) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.email = email;
        this.mobile = mobile;
        this.nic = nic;
        this.vehicle = vehicle;
        this.vehicle_type = vehicle_type;
    }

    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getPassword() { return password; }
    public String getEmail() { return email; }
    public String getMobile() { return mobile; }
    public String getNic() { return nic; }
    public String getVehicle() { return vehicle; }
    public String getVehicle_type() { return vehicle_type; }


    // Setters
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setPassword(String password) { this.password = password; }
    public void setEmail(String email) { this.email = email; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public void setNic(String nic) { this.nic = nic; }
    public void setVehicle(String vehicle) { this.vehicle = vehicle; }
    public void setVehicle_type(String vehicle_type) { this.vehicle_type = vehicle_type; }

}
