package Modelo;

import Auxiliar.Constantes;
import java.sql.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

public class ConexionEstatica {

    //********************* Atributos *************************
    private static java.sql.Connection Conex;
    //Atributo a través del cual hacemos la conexión física.
    private static java.sql.Statement Sentencia_SQL;
    //Atributo que nos permite ejecutar una sentencia SQL
    private static java.sql.ResultSet Conj_Registros;
    private static java.sql.ResultSet Fila;

    public static void nueva() {
        try {
            //Cargar el driver/controlador
            //String controlador = "com.mysql.jdbc.Driver";
            //String controlador = "com.mysql.cj.jdbc.Driver";
            //String controlador = "oracle.jdbc.driver.OracleDriver";
            //String controlador = "sun.jdbc.odbc.JdbcOdbcDriver"; 
            String controlador = "org.mariadb.jdbc.Driver"; // MariaDB la version libre de MySQL (requiere incluir la librería jar correspondiente).
            //Class.forName("org.mariadb.jdbc.Driver");              
            //Class.forName(controlador).newInstance();
            Class.forName(controlador);
            //Class.forName("com.mysql.jdbc.Driver"); 

            //String URL_BD = "jdbc:mysql://localhost:3306/" + Constantes.BBDD;
            //String URL_BD = "jdbc:mariadb://"+"localhost:3306"+"/"+Constantes.BBDD;
            //String URL_BD = "jdbc:oracle:oci:@REPASO";
            //String URL_BD = "jdbc:oracle:oci:@REPASO";
            //String URL_BD = "jdbc:odbc:REPASO";
            //String connectionString = "jdbc:mysql://localhost:3306/" + Constantes.BBDD + "?user=" + Constantes.usuario + "&password=" + Constantes.password + "&useUnicode=true&characterEncoding=UTF-8";
            //Realizamos la conexión a una BD con un usuario y una clave.
            //Conex = java.sql.DriverManager.getConnection(connectionString);
            //Conex = java.sql.DriverManager.getConnection(URL_BD, Constantes.usuario, Constantes.password);
            Conex = DriverManager.getConnection(
                    "jdbc:mariadb://localhost:3306/" + Constantes.BBDD, Constantes.usuario, Constantes.password);
            Sentencia_SQL = Conex.createStatement();
            System.out.println("Conexion realizada con éxito");
        } catch (Exception e) {
            System.err.println("Exception: " + e.getMessage());
        }
    }

    public static void cerrarBD() {
        try {
            // resultado.close();
            Conex.close();
            System.out.println("Desconectado de la Base de Datos"); // Opcional para seguridad
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error de Desconexion", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static boolean existeUsuario(String email, String passwd) {
        nueva();
        boolean existe = false;

        String sentencia = "Select * from users where email = '" + email + "' and passwd = '" + passwd + "'";

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                existe = true;
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return existe;
    }

    public static Persona getPersona(String email, String passwd) {
        nueva();
        Persona p = new Persona();
        String sentencia = "Select * from users where email = '" + email + "' and passwd = '" + passwd + "'";

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                p.setId(Conj_Registros.getInt(1));
                p.setName(Conj_Registros.getString(2));
                p.setSurname(Conj_Registros.getString(3));
                p.setEmail(Conj_Registros.getString(4));
                p.setPasswd(Conj_Registros.getString(5));
                p.setStatus(Conj_Registros.getInt(6));
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return p;
    }

    public static boolean esProfesor(Persona usuarioLogin) {
        nueva();
        boolean es = false;

        String sentencia = "Select * from asignacionRol where idUsuario = " + usuarioLogin.getId();

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                if (Conj_Registros.getInt(2) == 1) {
                    es = true;
                }
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return es;
    }

    public static boolean esAlumno(Persona usuarioLogin) {
        nueva();
        boolean es = false;

        String sentencia = "Select * from asignacionRol where idUsuario = " + usuarioLogin.getId();

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                if (Conj_Registros.getInt(2) == 2) {
                    es = true;
                }
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return es;
    }

    public static boolean registrarUsuario(String nombre, String apellidos, String email, String passwd) {
        nueva();
        boolean ok = false;

        String sentencia1 = "Insert into users values(Null,'" + nombre + "','" + apellidos + "','" + email + "','" + passwd + "', 1)";

        try {
            Sentencia_SQL.executeUpdate(sentencia1);
            String sentencia2 = "Select id from users where email = '" + email + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia2);
            if (Conj_Registros.next()) {
                int id = Conj_Registros.getInt(1);
                String sentencia3 = "Insert into asignacionRol values (" + id + ",2)";
                Sentencia_SQL.executeUpdate(sentencia3);
                ok = true;
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static LinkedList getExamenes() {
        nueva();
        LinkedList listaExamenes = new LinkedList();

        String sentencia = "Select * from examen";

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                Examen ex = new Examen();
                ex.setId(Conj_Registros.getString(1));
                ex.setIdProfesor(Conj_Registros.getInt(2));
                ex.setFechaInicio(Conj_Registros.getString(3));
                ex.setFechaFin(Conj_Registros.getString(4));
                ex.setEstado(Conj_Registros.getInt(5));
                ex.setTitulo(Conj_Registros.getString(6));
                ex.setDescripcion(Conj_Registros.getString(7));
                listaExamenes.add(ex);
            }
        } catch (SQLException ex) {

        }

        cerrarBD();
        return listaExamenes;
    }

    public static boolean finalizarExamen(int id) {
        nueva();
        boolean ok = false;

        String sentencia = "Update examen set estado = 2 Where id = " + id;

        try {
            Sentencia_SQL.executeUpdate(sentencia);
            ok = true;
        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static boolean activarExamen(int id) {
        nueva();
        boolean ok = false;

        String sentencia = "Update examen set estado = 1 Where id = " + id;

        try {
            Sentencia_SQL.executeUpdate(sentencia);
            ok = true;
        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static boolean borrarExamen(int id) {
        nueva();
        boolean ok = false;

        String sentencia = "Delete from examen Where id = " + id;

        try {
            Sentencia_SQL.executeUpdate(sentencia);
            ok = true;
        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static LinkedList getAlumnos(int idUsuario) {
        nueva();
        LinkedList<Persona> listaAlumnos = new LinkedList<Persona>();
        String sentencia = "SELECT asignacionRol.idUsuario, users.name,"
                + "users.surname, users.email, users.passwd, users.status from "
                + "asignacionRol, users WHERE asignacionRol.idUsuario=users.id "
                + "AND asignacionRol.idRol like 2 and asignacionRol.idUsuario <> " + idUsuario + " and users.id <> " + idUsuario;
        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                Persona aux = new Persona();
                aux.setId(Conj_Registros.getInt(1));
                aux.setName(Conj_Registros.getString(2));
                aux.setSurname(Conj_Registros.getString(3));
                aux.setEmail(Conj_Registros.getString(4));
                aux.setPasswd(Conj_Registros.getString(5));
                aux.setStatus(Conj_Registros.getInt(6));
                listaAlumnos.add(aux);
            }
        } catch (SQLException ex) {
        }
        cerrarBD();
        return listaAlumnos;
    }

    public static boolean editarAlumno(Persona aux) {
        nueva();
        boolean ok = false;

        if (aux.getPasswd().isEmpty()) {
            String sentencia = "Update users set name = '" + aux.getName() + "', surname = '" + aux.getSurname() + "', email = '" + aux.getEmail() + "', status = " + aux.getStatus() + " Where id = " + aux.getId();
            try {
                Sentencia_SQL.executeUpdate(sentencia);
                ok = true;
            } catch (SQLException ex) {
            }
        } else {
            String sentencia = "Update users set name = '" + aux.getName() + "', surname = '" + aux.getSurname() + "', email = '" + aux.getEmail() + "' passwd = '" + aux.getPasswd() + "', status = " + aux.getStatus() + " Where id = " + aux.getId();;
            try {
                Sentencia_SQL.executeUpdate(sentencia);
                ok = true;
            } catch (SQLException ex) {
            }

        }

        cerrarBD();
        return ok;
    }

    public static boolean borrarAlumno(int id) {
        nueva();
        boolean ok = false;

        String sentencia = "delete from users where id = " + id;
        try {
            Sentencia_SQL.executeUpdate(sentencia);
            ok = true;
        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static boolean agregarAlumno(Persona aux) {
        nueva();
        boolean ok = false;

        String sentencia1 = "insert into users values(NULL,'" + aux.getName() + "','" + aux.getSurname() + "','" + aux.getEmail() + "','" + aux.getPasswd() + "'," + aux.getStatus() + ");";
        try {
            Sentencia_SQL.executeUpdate(sentencia1);
            String sentencia2 = "Select id from users Where email = '" + aux.getEmail() + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia2);
            if (Conj_Registros.next()) {
                if (aux.getCargo().equals("Alumno")) {
                    String sentencia3 = "insert into asignacionRol values (" + Conj_Registros.getInt(1) + ",2)";
                    Sentencia_SQL.executeUpdate(sentencia3);
                    ok = true;
                }
                if (aux.getCargo().equals("Profesor")) {
                    String sentencia3 = "insert into asignacionRol values (" + Conj_Registros.getInt(1) + ",1)";
                    Sentencia_SQL.executeUpdate(sentencia3);
                    ok = true;
                }

            }
        } catch (SQLException ex) {
        }
        cerrarBD();
        return ok;
    }

    public static boolean crearPregunta(Pregunta aux) {
        nueva();
        boolean ok = false;
        int idExamen = -1;
        String tipo = aux.getTipo();
        String descripcion = aux.getDescripcion();
        String resp1 = aux.getRespuesta1();
        String resp2 = aux.getRespuesta2();
        String resp3 = aux.getRespuesta3();
        String resp4 = aux.getRespuesta4();
        String respCorrecta = aux.getRespuestaCorrecta();

        String sentencia1 = "INSERT INTO pregunta VALUES(NULL, " + idExamen + ",'" + descripcion + "')";

        try {
            Sentencia_SQL.executeUpdate(sentencia1);
            String sentencia2 = "SELECT idPregunta FROM pregunta where idExamen = " + idExamen + " AND pregunta = '" + descripcion + "'";
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia2);
            if (Conj_Registros.next()) {
                String idPregunta = Conj_Registros.getString("idPregunta");
                String sentencia3 = "INSERT INTO respuestaCorrecta VALUES(" + idPregunta + ",'" + tipo + "','" + resp1 + "','" + resp2 + "','" + resp3 + "','" + resp4 + "','" + respCorrecta + "')";
                Sentencia_SQL.executeUpdate(sentencia3);
                ok = true;
            }

        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static LinkedList getPreguntas() {
        nueva();
        LinkedList preguntasDisponibles = new LinkedList();

        String sentencia1 = "SELECT * FROM pregunta WHERE idExamen = -1";
        try {
            Fila = Sentencia_SQL.executeQuery(sentencia1);
            while (Fila.next()) {
                int idPregunta = Fila.getInt(1);
                int idExamen = Fila.getInt(2);
                String descripcion = Fila.getString(3);

                String sentencia2 = "SELECT tipo FROM respuestaCorrecta WHERE idPregunta = " + idPregunta;
                Conj_Registros = Sentencia_SQL.executeQuery(sentencia2);
                if (Conj_Registros.next()) {
                    String tipo = Conj_Registros.getString(1);
                    PreguntaAux aux = new PreguntaAux(idPregunta, idExamen, descripcion, tipo);
                    preguntasDisponibles.add(aux);
                }
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return preguntasDisponibles;
    }

    public static boolean addExamen(Examen ex) {
        nueva();
        boolean ok = false;

        int idProfesor = ex.getIdProfesor();
        String titulo = ex.getTitulo();
        String descripcion = ex.getDescripcion();

        String sentencia = "INSERT INTO examen VALUES(null," + idProfesor + ",NOW(), NOW(), 0,'" + titulo + "','" + descripcion + "')";
        try {
            Sentencia_SQL.executeUpdate(sentencia);
            ok = true;
        } catch (SQLException ex1) {
        }

        cerrarBD();
        return ok;
    }

    public static int getIdExamen(int idProfesor, String titulo, String descripcion) {
        nueva();
        int idExamen = 0;

        String sentencia = "select id from examen Where idProfesor = " + idProfesor + " AND titulo = '" + titulo + "' AND descripcion='" + descripcion + "'";

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                idExamen = Conj_Registros.getInt(1);
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return idExamen;
    }

    public static int getIdPregunta(String pre) {
        nueva();
        int id = 0;

        String sentencia = "SELECT idPregunta FROM pregunta WHERE pregunta = '" + pre + "'";

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                id = Conj_Registros.getInt(1);
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return id;
    }

    public static boolean asignarPreguntasExamen(int idExamen, int idPregunta) {
        nueva();
        boolean ok = false;

        String sentencia = "UPDATE pregunta SET idExamen = " + idExamen + " WHERE idPregunta = " + idPregunta;
        try {
            Sentencia_SQL.executeUpdate(sentencia);
            ok = true;
        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static LinkedList getExamenesProgramados() {
        nueva();
        LinkedList lista = null;
        Examen exProgramados = null;

        String sentencia = "SELECT * FROM examen WHERE estado = 1";

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                lista = new LinkedList();
                exProgramados = new Examen();
                exProgramados.setId(String.valueOf(Conj_Registros.getInt(1)));
                exProgramados.setIdProfesor(Conj_Registros.getInt(2));
                exProgramados.setFechaInicio(Conj_Registros.getString(3));
                exProgramados.setFechaFin(Conj_Registros.getString(4));
                exProgramados.setEstado(Conj_Registros.getInt(5));
                exProgramados.setTitulo(Conj_Registros.getString(6));
                exProgramados.setDescripcion(Conj_Registros.getString(7));
                lista.add(exProgramados);
            }
        } catch (SQLException ex1) {
        }

        cerrarBD();
        return lista;
    }

    public static LinkedList getExamenesCorregidos(int idAlumno) {
        nueva();
        LinkedList lista = null;
        ExamenAlumno exCorregidos = null;

        String sentencia1 = "SELECT * FROM examenAlumno WHERE idAlumno = " + idAlumno;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia1);
            //Obtenemos todos los examenes corregidos de ese alumno
            while (Conj_Registros.next()) {
                exCorregidos = new ExamenAlumno();
                lista = new LinkedList();
                exCorregidos.setIdExamen(Conj_Registros.getInt(1));
                exCorregidos.setIdAlumno(idAlumno);
                exCorregidos.setNota(Conj_Registros.getString(3));

                //Obtenemos el titulo del examen
                String sentencia2 = "SELECT titulo FROM examen WHERE id = " + exCorregidos.getIdExamen();
                Fila = Sentencia_SQL.executeQuery(sentencia2);
                if (Fila.next()) {
                    exCorregidos.setTitulo(Fila.getString(1));
                    lista.add(exCorregidos);
                }
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return lista;
    }

    public static Examen getExamen(int id) {
        nueva();
        Examen examen = null;

        String sentencia = "SELECT * FROM examen WHERE id = " + id;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                examen = new Examen();
                examen.setId(String.valueOf(id));
                examen.setIdProfesor(Conj_Registros.getInt(2));
                examen.setFechaInicio(Conj_Registros.getString(3));
                examen.setFechaFin(Conj_Registros.getString(4));
                examen.setEstado(Conj_Registros.getInt(5));
                examen.setTitulo(Conj_Registros.getString(6));
                examen.setDescripcion(Conj_Registros.getString(7));
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return examen;
    }

    public static LinkedList getPreguntasExamen(int idExamen) {
        nueva();
        LinkedList preguntasExamen = null;
        PreguntaAux aux = null;

        String sentencia1 = "SELECT * FROM pregunta WHERE idExamen=" + idExamen;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia1);
            preguntasExamen = new LinkedList();
            while (Conj_Registros.next()) {
                aux = new PreguntaAux();
                aux.setIdPregunta(Conj_Registros.getInt(1));
                aux.setIdExamen(Conj_Registros.getInt(2));
                aux.setDescripcion(Conj_Registros.getString(3));

                String consulta2 = "SELECT tipo FROM respuestaCorrecta WHERE idPregunta=" + aux.getIdPregunta();

                Fila = Sentencia_SQL.executeQuery(consulta2);

                if (Fila.next()) {
                    aux.setTipo(Fila.getString(1));
                    preguntasExamen.add(aux);
                }
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return preguntasExamen;
    }

    public static Pregunta getRespuestas(int id) {
        nueva();
        Pregunta pregunta = null;

        String sentencia = "SELECT * FROM respuestaCorrecta WHERE idPregunta=" + id;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                pregunta = new Pregunta();
                pregunta.setId(id);
                pregunta.setTipo(Conj_Registros.getString(2));
                pregunta.setRespuesta1(Conj_Registros.getString(3));
                pregunta.setRespuesta2(Conj_Registros.getString(4));
                pregunta.setRespuesta3(Conj_Registros.getString(5));
                pregunta.setRespuesta4(Conj_Registros.getString(6));
                pregunta.setRespuestaCorrecta(Conj_Registros.getString(7));
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return pregunta;
    }

    public static boolean isExamen(int idExamen, int idAlumno) {
        nueva();
        boolean ok = false;

        String sentencia = "SELECT * FROM respuestaAlumno WHERE idExamen=" + idExamen + " AND idAlumno=" + idAlumno;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                ok = true;
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return ok;
    }

    public static void deleteRespuestas(int idExamen, int idAlumno) {
        nueva();
        boolean delete = false;

        String sentencia = "DELETE FROM respuestasAlumnos WHERE id_Examen=" + idExamen + " AND idAlumno=" + idAlumno;

        try {
            Sentencia_SQL.executeUpdate(sentencia);
            delete = true;
        } catch (SQLException ex) {
        }

        cerrarBD();
    }

    public static void addRespuesta(int idExamen, int idAlumno, int idPregunta, String respuesta) {
        nueva();

        String sentencia = "INSERT INTO respuestaAlumno VALUES (" + idExamen + "," + idAlumno + "," + idPregunta + ",'" + respuesta + "'" + ")";

        try {
            Sentencia_SQL.executeUpdate(sentencia);
        } catch (SQLException ex) {
        }

        cerrarBD();
    }

    public static LinkedList getIDS(int id) {
        nueva();
        LinkedList lista = null;

        String sentencia = "SELECT DISTINCT idAlumno from respuestaAlumno WHERE idExamen=" + id;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            lista = new LinkedList();
            while (Conj_Registros.next()) {
                lista.add(Conj_Registros.getInt(1));
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return lista;
    }

    public static LinkedList getRespuestasAlumno(int idAlumno, int idExamen) {
        nueva();
        LinkedList lista = null;
        RespuestaAlumno aux = null;

        String sentencia = "SELECT * FROM respuestaAlumno WHERE idAlumno=" + idAlumno + " AND idExamen=" + idExamen;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            lista =  new LinkedList();
            while (Conj_Registros.next()) {
                aux = new RespuestaAlumno(Conj_Registros.getInt(1), Conj_Registros.getInt(2), Conj_Registros.getInt(3), Conj_Registros.getString(4));
                lista.add(aux);
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return lista;
    }

    public static String getCorrecta(int idPregunta) {
        nueva();
        String resp = "";

        String sentencia = "SELECT respuestaCorrecta FROM respuestaCorrecta WHERE idPregunta=" + idPregunta;

        try {
            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
            if (Conj_Registros.next()) {
                resp = Conj_Registros.getString(1);
            }
        } catch (SQLException ex) {
        }

        cerrarBD();
        return resp;
    }

    public static void setNota(int idExamen, int idAlumno, String nota) {
        nueva();

        String sentencia = "INSERT INTO examenAlumno VALUES(" + idExamen + "," + idAlumno + ",'" + nota + "')";

        try {
            Sentencia_SQL.executeUpdate(sentencia);
        } catch (SQLException ex) {
        }

        cerrarBD();
    }

    public static void actualizarEstado(int idExamen) {
        nueva();

        String sentencia = "UPDATE examen SET estado=3 WHERE id=" + idExamen;

        try {
            Sentencia_SQL.executeUpdate(sentencia);
        } catch (SQLException ex) {
        }

        cerrarBD();
    }

}
