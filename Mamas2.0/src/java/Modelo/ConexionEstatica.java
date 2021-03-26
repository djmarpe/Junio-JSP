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
                ex.setId(Conj_Registros.getInt(1));
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
//
//    public static boolean enviarMensaje(String emisor, String receptor, String asunto, String cuerpo) {
//        nueva();
//        boolean enviado = false;
//
//        String sentencia = "Insert into " + Constantes.tablaMensaje + " values( Null, '" + asunto + "', '" + cuerpo + "', '" + emisor + "', '" + receptor + "')";
//
//        try {
//            Sentencia_SQL.executeUpdate(sentencia);
//            enviado = true;
//        } catch (SQLException ex) {
//        }
//
//        cerrarBD();
//        return enviado;
//
//    }
//
//    public static int existeUsuarioMensaje(String usuario) {
//        nueva();
//
//        //cod = 0 --> Todo OK
//        int cod = -9;
//
//        String sentencia = "Select * from " + Constantes.tablaUsuario + " where Email = '" + usuario + "';";
//
//        try {
//            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
//            if (ConexionEstatica.Conj_Registros.next()) {
//                cod = 0;
//            }
//        } catch (SQLException ex) {
//            cod = ex.getErrorCode();
//        }
//
//        cerrarBD();
//
//        return cod;
//
//    }
//
//    public static int existeUsuario(String usuario, String clave) {
//        nueva();
//
//        //cod = 0 --> Todo OK
//        int cod = -9;
//
//        String sentencia = "Select * from " + Constantes.tablaUsuario + " where Email = '" + usuario + "' and Contra = '" + clave + "';";
//
//        try {
//            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
//            if (ConexionEstatica.Conj_Registros.next()) {
//                cod = 0;
//            }
//        } catch (SQLException ex) {
//            cod = ex.getErrorCode();
//        }
//
//        cerrarBD();
//
//        return cod;
//
//    }
//
//    public static boolean addUsuario(Persona p) {
//        nueva();
//        boolean ok = false;
//
//        //--------------------- Insertamos en la tabla Usuarios ----------------
//        String sentencia1 = "Insert into Usuario values('" + p.getNombre() + "', '" + p.getApellidos() + "', '" + p.getDni() + "', '" + p.getEmail() + "','" + p.getContra() + "', " + p.getEdad() + ", '" + p.getFoto() + "', " + p.getSexo() + ", " + p.getActivado() + ");";
//
//        try {
//            Sentencia_SQL.executeUpdate(sentencia1);
//            ok = true;
//        } catch (SQLException ex) {
//        }
//
//        //--------------------- Asignamos Rol en la tabla ----------------------
//        String sentencia2 = "Insert into AsignacionRol values(Null, '2', '" + p.getEmail() + "');";
//
//        try {
//            Sentencia_SQL.executeUpdate(sentencia2);
//            ok = true;
//        } catch (SQLException ex) {
//        }
//
//        cerrarBD();
//        return ok;
//    }
//
//    public static boolean eliminarUsuario(String usuario, String clave) {
//        nueva();
//
//        boolean eliminado = false;
//
//        //------------------ Eliminacion de la tabla Usuarios ------------------
//        String sentencia1 = "delete from Usuario where Email = '" + usuario + "' and Contra = '" + clave + "';";
//        try {
//
//            Sentencia_SQL.executeUpdate(sentencia1);
//            eliminado = true;
//
//        } catch (SQLException ex) {
//        }
//
//        //----------------- Eliminacion de los roles asignados ----------------
//        String sentencia2 = "delete from AsignacionRol where emailUsuario = '" + usuario + "';";
//        try {
//            Sentencia_SQL.executeUpdate(sentencia2);
//            eliminado = true;
//        } catch (SQLException ex) {
//        }
//
//        cerrarBD();
//        return eliminado;
//    }
//
//    public static boolean modificarUsuario(Persona p) {
//        nueva();
//        boolean modificado = false;
//
//        //------------------- Modificando en la tabla Usuario ------------------
//        String sentencia1 = "update Usuario set Nombre = '" + p.getNombre() + "', Apellidos = '" + p.getApellidos() + "', DNI = '" + p.getDni() + "', Email='" + p.getEmail() + "', Contra='" + p.getContra() + "', Edad=" + p.getEdad() + ", Sexo=" + p.getSexo() + ", Activado=" + p.getActivado() + " Where Email='" + p.getEmail() + "'";
//
//        try {
//            Sentencia_SQL.executeUpdate(sentencia1);
//            modificado = true;
//        } catch (SQLException ex) {
//        }
//
//        //---------------- Modificando en la tabla AsignacionRol ---------------
//        if (p.getEsAdmin() == 1) {
//            if (!ConexionEstatica.esAdmin(p.getEmail())) {
//                String sentencia2 = "Insert into AsignacionRol values(Null, '1', '" + p.getEmail() + "');";
//                try {
//                    nueva();
//                    Sentencia_SQL.executeUpdate(sentencia2);
//                    cerrarBD();
//                    modificado = true;
//                } catch (SQLException ex) {
//                }
//            }
//        }
//
//        if (p.getEsAdmin() == 0) {
//            if (ConexionEstatica.esAdmin(p.getEmail())) {
//                String sentencia2 = "Delete from AsignacionRol Where emailUsuario = '" + p.getEmail() + "' and idRol=1;";
//                try {
//                    nueva();
//                    Sentencia_SQL.executeUpdate(sentencia2);
//                    cerrarBD();
//                    modificado = true;
//                } catch (SQLException ex) {
//                }
//            }
//        }
//
//        cerrarBD();
//        return modificado;
//    }
//
//    public static Persona getPersona(String usuario, String clave) {
//        nueva();
//
//        Persona p = new Persona();
//
//        String sentencia = "Select Usuario.Nombre, Usuario.Apellidos, Usuario.DNI, Usuario.Email, Usuario.Contra, Usuario.Edad, Usuario.Foto, Usuario.Sexo, Rol.Rol from Usuario, Rol, AsignacionRol where Usuario.Email = '" + usuario + "' and Usuario.Contra = '" + clave + "' and AsignacionRol.emailUsuario = Usuario.Email and AsignacionRol.idRol=Rol.idRol;";
//
//        try {
//            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
//            while (Conj_Registros.next()) {
//                p.setNombre(Conj_Registros.getString("Nombre"));
//                p.setApellidos(Conj_Registros.getString("Apellidos"));
//                p.setDni(Conj_Registros.getString("DNI"));
//                p.setEmail(Conj_Registros.getString("Email"));
//                p.setContra(Conj_Registros.getString("Contra"));
//                p.setEdad(Conj_Registros.getString("Edad"));
//                //p.setFoto(Conj_Registros.getString("Foto"));
//                p.setSexo(Conj_Registros.getInt("Sexo"));
//                p.addRol(Conj_Registros.getString("Rol"));
//            }
//
//        } catch (SQLException ex) {
//        }
//        cerrarBD();
//        return p;
//    }
//
//    public static LinkedList<Persona> getGenteCercana(Persona p) {
//        nueva();
//        LinkedList<Persona> lp = new LinkedList<>();
//        Persona aux = null;
//        String sentencia = "select * from " + Constantes.tablaUsuario + " Where DNI <> '" + p.getDni() + "';";
//
//        try {
//            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
//            while (Conj_Registros.next()) {
//                aux = new Persona();
//                aux.setNombre(Conj_Registros.getString("Nombre"));
//                aux.setApellidos(Conj_Registros.getString("Apellidos"));
//                aux.setDni(Conj_Registros.getString("DNI"));
//                aux.setEmail(Conj_Registros.getString("Email"));
//                aux.setContra(Conj_Registros.getString("Contra"));
//                aux.setEdad(Conj_Registros.getString("Edad"));
//                aux.setFoto(Conj_Registros.getString("Foto"));
//                aux.setActivado(Conj_Registros.getInt("Activado"));
//                aux.setSexo(Conj_Registros.getInt("Sexo"));
//                lp.add(aux);
//            }
//        } catch (SQLException ex) {
//        }
//
//        cerrarBD();
//        return lp;
//    }
//
//    public static LinkedList getRoles() {
//        nueva();
//
//        LinkedList roles = new LinkedList();
//
//        String sentencia = "Select Rol from " + Constantes.tablaRol;
//
//        try {
//            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
//            while (Conj_Registros.next()) {
//                roles.add(Conj_Registros.getString("Rol"));
//            }
//        } catch (SQLException ex) {
//        }
//        cerrarBD();
//        return roles;
//    }
//
//    public static LinkedList getAdministradores() {
//        nueva();
//        LinkedList administradores = new LinkedList();
//        Persona p = null;
//        String sentencia = "select * from Usuario, AsignacionRol WHERE AsignacionRol.emailUsuario=Usuario.Email and AsignacionRol.idRol=1;";
//
//        try {
//            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
//            while (Conj_Registros.next()) {
//                p = new Persona();
//                p.setNombre(Conj_Registros.getString("Nombre"));
//                p.setApellidos(Conj_Registros.getString("Apellidos"));
//                p.setDni(Conj_Registros.getString("DNI"));
//                p.setEmail(Conj_Registros.getString("Email"));
//                p.setContra(Conj_Registros.getString("Contra"));
//                p.setEdad(Conj_Registros.getString("Edad"));
//                p.setSexo(Conj_Registros.getInt("Sexo"));
//                p.setActivado(Conj_Registros.getInt("Activado"));
//                administradores.add(p);
//            }
//        } catch (SQLException ex) {
//        }
//
//        cerrarBD();
//        return administradores;
//    }
//
//    public static LinkedList getUsuarios() {
//        nueva();
//        LinkedList usuarios = new LinkedList();
//        Persona p = null;
//        String sentencia = "select * from Usuario, AsignacionRol WHERE AsignacionRol.emailUsuario=Usuario.Email and AsignacionRol.idRol=2;";
//
//        try {
//            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
//            while (Conj_Registros.next()) {
//                p = new Persona();
//                p.setNombre(Conj_Registros.getString("Nombre"));
//                p.setApellidos(Conj_Registros.getString("Apellidos"));
//                p.setDni(Conj_Registros.getString("DNI"));
//                p.setEmail(Conj_Registros.getString("Email"));
//                p.setContra(Conj_Registros.getString("Contra"));
//                p.setEdad(Conj_Registros.getString("Edad"));
//                p.setSexo(Conj_Registros.getInt("Sexo"));
//                p.setActivado(Conj_Registros.getInt("Activado"));
//                usuarios.add(p);
//            }
//        } catch (SQLException ex) {
//        }
//
//        cerrarBD();
//        return usuarios;
//    }
//
//    private static boolean esAdmin(String email) {
//        nueva();
//        boolean loes = false;
//        String sentencia = "Select * from AsignacionRol where emailUsuario = '" + email + "';";
//
//        try {
//            Conj_Registros = Sentencia_SQL.executeQuery(sentencia);
//            while (Conj_Registros.next()) {
//                if (Conj_Registros.getInt("idRol") == 1) {
//                    loes = true;
//                }
//            }
//        } catch (SQLException ex) {
//        }
//        cerrarBD();
//        return loes;
//    }
}
