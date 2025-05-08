package com.IoTBay.model;

import java.io.Serializable;

public class User implements Serializable {

    private int id;
    private String FName;
    private String LName;
    private String Email;
    private String password;
    private String address;
    private String phone;
    private int mobile;
    private String city;
    private String state;
    private boolean isAdmin;


    public User(String FName, String LName, String Email, String password, String address, String phone, String city, String state) {
        this.FName = FName;
        this.LName = LName;
        this.Email = Email;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.city = city;
        this.state = state;
    }

    //Adding admin
    public User(String FName, String LName, String Email, String password, String address, String phone, String city, String state, boolean isAdmin) {
        this.FName = FName;
        this.LName = LName;
        this.Email = Email;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.city = city;
        this.state = state;
        this.isAdmin = isAdmin;
    }

    public User(int id,String FName, String LName, String Email, String password, String address, String phone, String city, String state, boolean isAdmin) {
        this.id = id;
        this.FName = FName;
        this.LName = LName;
        this.Email = Email;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.city = city;
        this.state = state;
        this.isAdmin = isAdmin;
    }

    public  User(int id, String FName, String LName, String Email, String password, String address, String phone, String city, String state) {
        this.id = id;
        this.FName = FName;
        this.LName = LName;
        this.Email = Email;
        this.password = password;
        this.address = address;
        this.phone = phone;
        this.city = city;
        this.state = state;
    }

    public int getId() {
        return id;
    }

    public String getFName() {
        return FName;
    }

    public String getLName() {
        return LName;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return Email;
    }

    public String getAddress() {return address; }

    public String getCity() {return city; }

    public String getState() {return state; }

    public String getPhone() {return phone; }

    public boolean getAdmin() {return isAdmin; }

    public void setId(int id) {
        this.id = id;
    }

    public void setFName(String FName) {
        this.FName = FName;
    }

    public void setLName(String LName) {
        this.LName = LName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.Email = email;
    }
}
