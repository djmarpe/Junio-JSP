<%-- 
    Document   : panelProfesor.jsp
    Created on : 16-mar-2021, 19:21:57
    Author     : alejandro
--%>

<%@page import="org.apache.jasper.tagplugins.jstl.ForEach"%>
<%@page import="Modelo.Examen"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../css/miCss.css">
        <title>Administrador de Alumnos</title>
    </head>
    <body class="bg-dark-blue text-white">
        <%
            Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
            LinkedList<Persona> listaAlumnos = null;
            if (session.getAttribute("listaAlumnos") != null) {
                listaAlumnos = (LinkedList<Persona>) session.getAttribute("listaAlumnos");
            }
        %>
        <div class="sticky-top bg-dark-blue py-2">
            <header class="row m-0 py-3">
                <div class="col-6 align-self-center">
                    <h3 class="m-0">Mamas 2.0</h3>
                </div>

                <div class="col-6 align-self-center">
                    <a href="../controlador/controlador.jsp?cerrarSesion=cerrarSesion" class="float-end mx-3 btn btn-danger">Cerrar sesión</a>
                    <a href="panelAlumno.jsp" class="float-end mx-3 btn btn-secondary">Vista alumno</a>
                </div>
            </header>
            <div class="row bg-white m-3">
                <div class="col-12 text-muted">
                    <strong>Bienvenido:&nbsp;</strong><small><%= usuarioLogin.getName() + ' ' + usuarioLogin.getSurname()%></small>
                </div>
            </div>
            <div class="row m-3 bg-white">
                <div class="col-12" id="menu-list">
                    <div class="navbar m-0 p-2 navbar-brand ">
                        <a class="navbar-brand text-dark" href="#">
                            Crear examen
                        </a>
                        <a class="navbar-brand text-dark" href="crearPreguntas.jsp">
                            Crear preguntas
                        </a>
                        <a class="navbar-brand text-dark" href="../controlador/controlador.jsp?adminExamenes=adminExamenes">
                            Admin. examenes
                        </a>
                        <a class="navbar-brand text-dark text-decoration-underline" href="../controlador/controlador.jsp?adminAlumnos=adminAlumnos">
                            Admin. usuarios
                        </a>

                    </div>
                </div>
            </div>
        </div>
        <div class="row m-3 bg-white text-dark p-3">
            <div class="col-12 d-flex justify-content-between">
                <table class="w-100 my-5">
                    <tr class="m-5">
                        <th class="h3 w-auto">Nombre</th>
                        <th class="h3 w-auto">Apellidos</th>
                        <th class="h3 w-auto">Correo electrónico</th>
                        <th class="h3 w-auto">Contraseña</th>
                        <th class="h3 w-auto text-center">Estado</th>
                        <th class="h3 w-auto text-center">Cargo</th>
                        <th class="h3 w-auto text-center">Acciones</th>
                    </tr>
                    <form action="../controlador/controlador.jsp" method="POST">
                        <tr>
                        <td class="w-auto">
                            <input class="form-control" type="text" name="name_alumno" placeholder="Nombre">
                        </td>
                        <td class="w-auto">
                            <input class="form-control" type="text" name="surname_alumno" placeholder="Apellidos">
                        </td>
                        <td class="w-auto">
                            <input class="form-control" type="text" name="email_alumno" placeholder="Email">
                        </td>
                        <td class="w-auto">
                            <input class="form-control" type="password" name="passwd_alumno" placeholder="Contraseña">
                        </td>
                        <td class="w-auto text-center">
                            <select name="status_alumno" class="form-select">
                                <option selected>
                                    Activado
                                </option>
                                <option>
                                    Desactivado
                                </option>
                            </select>
                        </td>
                        <td class="w-auto text-center">
                            <select name="cargo_alumno" class="form-select">
                                <option selected>
                                    Alumno
                                </option>
                                <option>
                                    Profesor
                                </option>
                            </select>
                        </td>
                        <td class="w-auto text-center">
                            <button class="btn m-0 p-0" type="submit" name="alumnos_btn_agregar"><i class="fas fa-plus-square text-info"></i></button>
                        </td>
                        </tr>
                    </form>
                </table>
            </div>
            
            <div class="col-12 d-flex justify-content-between">
                <%
                    if (listaAlumnos != null) {
                %>

                <table class="w-100 my-5">
                    <tr class="m-5">
                        <th class="h3 w-auto">Nombre</th>
                        <th class="h3 w-auto">Apellidos</th>
                        <th class="h3 w-auto">Correo electrónico</th>
                        <th class="h3 w-auto">Contraseña</th>
                        <th class="h3 w-auto text-center">Estado</th>
                        <th class="h3 w-auto text-center">Acciones</th>
                    </tr>
                    <%
                        if (listaAlumnos.size() > 0) {
                            for (int i = 0; i < listaAlumnos.size(); i++) {
                                Persona aux = listaAlumnos.get(i);

                    %>
                    <form action="../controlador/controlador.jsp" method="POST">
                        <tr>
                        <input type="hidden" name="idAlumno" value="<%= aux.getId()%>">
                        <td class="w-auto">
                            <input class="form-control" type="text" name="name_alumno" value="<%= aux.getName()%>">
                        </td>
                        <td class="w-auto">
                            <input class="form-control" type="text" name="surname_alumno" value="<%= aux.getSurname()%>">
                        </td>
                        <td class="w-auto">
                            <input class="form-control" type="text" name="email_alumno" value="<%= aux.getEmail()%>">
                        </td>
                        <td class="w-auto">
                            <input class="form-control" type="password" name="passwd_alumno" placeholder="Nueva contraseña">
                        </td>
                        <td class="w-auto text-center">
                            <select name="status_alumno" class="form-select">
                                <%
                                    if (aux.getStatus() == 1) {
                                %>
                                <option selected>
                                    Activado
                                </option>
                                <option>
                                    Desactivado
                                </option>
                                <%
                                } else {
                                %>
                                <option>
                                    Activado
                                </option>
                                <option selected>
                                    Desactivado
                                </option>
                                <%
                                    }
                                %>

                            </select>
                        </td>
                        <td class="w-auto text-center">
                            <button class="btn m-0 p-0" type="submit" name="alumnos_btn_editar"><i class="fas fa-pencil-alt text-warning"></i></button>
                            <button class="btn m-0 p-0" type="submit" name="alumnos_btn_borrar"><i class="fas fa-trash-alt text-danger"></i></button>
                        </td>
                        </tr>
                    </form>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="6" class="text-center">
                            No hay alumnos en este momento
                        </td>
                    </tr>
                    <%    }
                    %>
                </table>
                <%
                    }
                %>
            </div>
        </div>
    </body>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/all.min.js"></script>
</html>
