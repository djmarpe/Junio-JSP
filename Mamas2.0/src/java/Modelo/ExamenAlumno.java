/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelo;

/**
 *
 * @author alejandro
 */
public class ExamenAlumno {
    private int idExamen;
    private String titulo;
    private int idAlumno;
    private String nota;

    public ExamenAlumno(int idExamen, String titulo, int idAlumno, String nota) {
        this.idExamen = idExamen;
        this.titulo = "";
        this.idAlumno = idAlumno;
        this.nota = nota;
    }
    
    public ExamenAlumno(){
        this.idExamen = 0;
        this.titulo = "";
        this.idAlumno = 0;
        this.nota = "";
    }

    public int getIdExamen() {
        return idExamen;
    }

    public void setIdExamen(int idExamen) {
        this.idExamen = idExamen;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public int getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }

    public String getNota() {
        return nota;
    }

    public void setNota(String nota) {
        this.nota = nota;
    }
    
}
