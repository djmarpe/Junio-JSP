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
public class RespuestaAlumno {
    private int idExamen;
    private int idAlumno;
    private int idPregunta;
    private String respuesta;

    public RespuestaAlumno(int idExamen, int idAlumno, int idPregunta, String respuesta) {
        this.idExamen = idExamen;
        this.idAlumno = idAlumno;
        this.idPregunta = idPregunta;
        this.respuesta = respuesta;
    }

    public RespuestaAlumno() {
    }

    public int getIdExamen() {
        return idExamen;
    }

    public void setIdExamen(int idExamen) {
        this.idExamen = idExamen;
    }

    public int getIdAlumno() {
        return idAlumno;
    }

    public void setIdAlumno(int idAlumno) {
        this.idAlumno = idAlumno;
    }

    public int getIdPregunta() {
        return idPregunta;
    }

    public void setIdPregunta(int idPregunta) {
        this.idPregunta = idPregunta;
    }

    public String getRespuesta() {
        return respuesta;
    }

    public void setRespuesta(String respuesta) {
        this.respuesta = respuesta;
    }
    
}
