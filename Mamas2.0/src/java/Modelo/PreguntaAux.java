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
public class PreguntaAux {
    private int idPregunta;
    private int idExamen;
    private String descripcion;
    private String tipo;

    public PreguntaAux(int idPregunta, int idExamen, String descripcion, String tipo) {
        this.idPregunta = idPregunta;
        this.idExamen = idExamen;
        this.descripcion = descripcion;
        this.tipo = tipo;
    }

    public PreguntaAux() {
    }

    public int getIdPregunta() {
        return idPregunta;
    }

    public void setIdPregunta(int idPregunta) {
        this.idPregunta = idPregunta;
    }

    public int getIdExamen() {
        return idExamen;
    }

    public void setIdExamen(int idExamen) {
        this.idExamen = idExamen;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
}
