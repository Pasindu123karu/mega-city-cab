package com.megacab.registration;

public class User {
    private int id;
    private String name;
    private String email;
    private String mobile;
    private String address;
    private String nic;


    // Default constructor (needed for setters)
    public User() {}

    // Parameterized constructor
    public User(int id, String name, String email, String mobile, String address, String nic) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.mobile = mobile;
        this.address = address;
        this.nic = nic;

    }

    // Getters
    public int getId() { return id; }
    public String getName() { return name; }
    public String getEmail() { return email; }
    public String getMobile() { return mobile; }
    public String getAddress() { return address; }
    public String getNic() { return nic; }


    // Setters
    public void setId(int id) { this.id = id; }
    public void setName(String name) { this.name = name; }
    public void setEmail(String email) { this.email = email; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public void setAddress(String address) { this.address = address; }
    public void setNic(String nic) { this.nic = nic; }

}
