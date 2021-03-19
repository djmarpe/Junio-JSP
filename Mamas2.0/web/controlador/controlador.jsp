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