<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Examen"%>
<%@page import="Modelo.Persona"%>
<%@page import="Modelo.ConexionEstatica"%>
<%
    //**************************************************************************
    //************************* Vista Home *************************************
    //**************************************************************************
    if (request.getParameter("login") != null) {
        session.removeAttribute("msj");
        response.sendRedirect("../Vistas/login.jsp");
    }

    if (request.getParameter("registro") != null) {
        session.removeAttribute("msj");
        response.sendRedirect("../Vistas/registro.jsp");
    }

    //**************************************************************************
    //************************* Vista Login ************************************
    //**************************************************************************
    if (request.getParameter("btn_login") != null) {
        String email = request.getParameter("email_login");
        String passwd = request.getParameter("passwd_login");
        if (ConexionEstatica.existeUsuario(email, passwd)) {
            Persona usuarioLogin = ConexionEstatica.getPersona(email, passwd);
            if (ConexionEstatica.esProfesor(usuarioLogin)) {
                LinkedList<Examen> listaExamen = (LinkedList<Examen>) ConexionEstatica.getExamenes();
                session.setAttribute("listaExamen", listaExamen);
                response.sendRedirect("../Vistas/panelProfesor.jsp");
            }
            if (ConexionEstatica.esAlumno(usuarioLogin)) {
                response.sendRedirect("../Vistas/panelAlumno.jsp");
            }
            session.setAttribute("usuarioLogin", usuarioLogin);
        } else {
            session.setAttribute("msj", "Credenciales inválidas");
            response.sendRedirect("../Vistas/login.jsp");
        }
    }

    //**************************************************************************
    //************************* Cerrar sesion **********************************
    //**************************************************************************
    if (request.getParameter("cerrarSesion") != null) {
        session.removeAttribute("usuarioLogin");
        session.removeAttribute("msj");
        response.sendRedirect("../index.jsp");
    }

    //**************************************************************************
    //************************* Admin Alumnos **********************************
    //**************************************************************************
    if (request.getParameter("adminAlumnos") != null) {
        Persona aux = (Persona) session.getAttribute("usuarioLogin");
        LinkedList<Persona> listaAlumnos = ConexionEstatica.getAlumnos(aux.getId());
        session.setAttribute("listaAlumnos", listaAlumnos);
        response.sendRedirect("../Vistas/adminAlumnos.jsp");
    }

    if (request.getParameter("alumnos_btn_editar") != null) {
        Persona aux = new Persona();
        Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
        aux.setId(Integer.parseInt(request.getParameter("idAlumno")));
        aux.setName(request.getParameter("name_alumno"));
        aux.setSurname(request.getParameter("surname_alumno"));
        aux.setEmail(request.getParameter("email_alumno"));
        aux.setPasswd(request.getParameter("passwd_alumno"));
        if (request.getParameter("status_alumno").equals("Activado")) {
            aux.setStatus(1);
        } else {
            aux.setStatus(0);
        }
        if (ConexionEstatica.editarAlumno(aux)) {
            session.removeAttribute("listaAlumnos");
            LinkedList<Persona> listaAlumnos = ConexionEstatica.getAlumnos(usuarioLogin.getId());
            session.setAttribute("listaAlumnos", listaAlumnos);
            response.sendRedirect("../Vistas/adminAlumnos.jsp");
        }
    }

    if (request.getParameter("alumnos_btn_borrar") != null) {
        Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
        int id = Integer.parseInt(request.getParameter("idAlumno"));
        if (ConexionEstatica.borrarAlumno(id)) {
            session.removeAttribute("listaAlumnos");
            LinkedList<Persona> listaAlumnos = ConexionEstatica.getAlumnos(usuarioLogin.getId());
            session.setAttribute("listaAlumnos", listaAlumnos);
            response.sendRedirect("../Vistas/adminAlumnos.jsp");
        }
    }

    if (request.getParameter("alumnos_btn_agregar") != null) {
        Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
        Persona aux = new Persona();
        aux.setName(request.getParameter("name_alumno"));
        aux.setSurname(request.getParameter("surname_alumno"));
        aux.setEmail(request.getParameter("email_alumno"));
        aux.setPasswd(request.getParameter("passwd_alumno"));
        switch (request.getParameter("status_alumno")) {
            case "Activado":
                aux.setStatus(1);
                break;
            case "Desactivado":
                aux.setStatus(2);
        }
        aux.setCargo(request.getParameter("cargo_alumno"));
        if (ConexionEstatica.agregarAlumno(aux)) {
            session.removeAttribute("listaAlumnos");
            LinkedList<Persona> listaAlumnos = ConexionEstatica.getAlumnos(usuarioLogin.getId());
            session.setAttribute("listaAlumnos", listaAlumnos);
            response.sendRedirect("../Vistas/adminAlumnos.jsp");
        }
    }

    //**************************************************************************
    //************************* CRUD examenes **********************************
    //**************************************************************************
    //Si pulsamos sobre el boton de parar
    if (request.getParameter("examenes_btn_parar") != null) {
        int id = Integer.parseInt(request.getParameter("idExamen"));
        if (ConexionEstatica.finalizarExamen(id)) {
            session.removeAttribute("listaExamen");
            LinkedList<Examen> listaExamen = (LinkedList<Examen>) ConexionEstatica.getExamenes();
            session.setAttribute("listaExamen", listaExamen);
            response.sendRedirect("../Vistas/panelProfesor.jsp");
        }
    }
    //Si pulsamos sobre el boton de iniciar
    if (request.getParameter("examenes_btn_activar") != null) {
        int id = Integer.parseInt(request.getParameter("idExamen"));
        if (ConexionEstatica.activarExamen(id)) {
            session.removeAttribute("listaExamen");
            LinkedList<Examen> listaExamen = (LinkedList<Examen>) ConexionEstatica.getExamenes();
            session.setAttribute("listaExamen", listaExamen);
            response.sendRedirect("../Vistas/panelProfesor.jsp");
        }
    }
    //Si pulsamos sobre el boton de parar
    if (request.getParameter("examenes_btn_borrar") != null) {
        int id = Integer.parseInt(request.getParameter("idExamen"));
        if (ConexionEstatica.borrarExamen(id)) {
            session.removeAttribute("listaExamen");
            LinkedList<Examen> listaExamen = (LinkedList<Examen>) ConexionEstatica.getExamenes();
            session.setAttribute("listaExamen", listaExamen);
            response.sendRedirect("../Vistas/panelProfesor.jsp");
        }
    }
    //Si pulsamos sobre el boton de parar
    if (request.getParameter("examenes_btn_corregir") != null) {
        int id = Integer.parseInt(request.getParameter("idExamen"));
    }
%>