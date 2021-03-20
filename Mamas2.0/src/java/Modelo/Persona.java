/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

import java.util.LinkedList;

/**
 *
 * @author alejandro
 */
public class Persona {

    private int id;
    private String name;
    private String surname;
    private String email;
    private String passwd;
    private String cargo;
    private int status;

    public Persona(int id, String name, String surname, String email, String passwd, int status) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.email = email;
        this.passwd = passwd;
        this.status = status;
    }

    public Persona() {
        this.id = 0;
        this.name = "";
        this.surname = "";
        this.email = "";
        this.passwd = "";
        this.status = 0;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }
    
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
