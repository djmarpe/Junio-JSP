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
%>