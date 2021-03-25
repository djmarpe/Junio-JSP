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
        <title>Administrador de exámenes</title>
    </head>
    <body class="bg-dark-blue text-white">
        <%
            Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
            LinkedList<Examen> listaExamen = null;
            LinkedList<Examen> examenesDesactivados = new LinkedList<Examen>();
            LinkedList<Examen> examenesActivos = new LinkedList<Examen>();
            LinkedList<Examen> examenesFinalizados = new LinkedList<Examen>();
            LinkedList<Examen> examenesCorregidos = new LinkedList<Examen>();
            if (session.getAttribute("listaExamen") != null) {
                listaExamen = (LinkedList<Examen>) session.getAttribute("listaExamen");
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
                        <a class="navbar-brand text-dark text-decoration-underline" href="../controlador/controlador.jsp?adminExamenes=adminExamenes">
                            Admin. examenes
                        </a>
                        <a class="navbar-brand text-dark" href="../controlador/controlador.jsp?adminAlumnos=adminAlumnos">
                            Admin. usuarios
                        </a>

                    </div>
                </div>
            </div>
        </div>
        <div class="row m-3 bg-white text-dark p-3">
            <div class="col-12 d-flex justify-content-between">
                <%
                    if (listaExamen != null) {
                %>

                <table class="w-100">
                    <tr class="m-5">
                        <th class="h3 w-25">Título</th>
                        <th class="h3 w-25">Descripción</th>
                        <th class="h3 w-25">Fecha</th>
                        <th class="h3 w-auto">Estado</th>
                        <th class="h3 w-auto">Acciones</th>
                    </tr>
                    <%
                        //Separamos los examenes por estado
                        for (int i = 0; i < listaExamen.size(); i++) {
                            Examen aux = listaExamen.get(i);

                            switch (aux.getEstado()) {
                                case 0:
                                    examenesDesactivados.add(aux);
                                    break;
                                case 1:
                                    examenesActivos.add(aux);
                                    break;
                                case 2:
                                    examenesFinalizados.add(aux);
                                    break;
                                case 3:
                                    examenesCorregidos.add(aux);
                                    break;
                            }

                        }
                    %>
                    <tr>
                        <td colspan="4" class="text-center h5">Exámenes en proceso</td>
                    </tr>
                    <%
                        if (examenesActivos.size() > 0) {
                            for (int i = 0; i < examenesActivos.size(); i++) {
                                Examen aux = examenesActivos.get(i);

                    %>
                    <form action="../controlador/controlador.jsp" method="POST">
                        <tr>
                        <input type="hidden" name="idExamen" value="<%= aux.getId()%>">
                        <td class="w-25">
                            <%= aux.getTitulo()%>
                        </td>
                        <td class="w-25">
                            <%= aux.getDescripcion()%>
                        </td>
                        <td class="w-25">
                            <div class="w-100">
                                <small>F. inicio:</small>
                                <small><%= aux.getFechaInicio()%></small>
                            </div>
                            <div class="w-100">
                                <small>F. fin:</small>
                                <small><%= aux.getFechaFin()%></small>
                            </div>
                        </td>
                        <td>
                            <i class="fas fa-circle text-success"></i>
                        </td>
                        <td>
                            <button class="btn m-0 p-0 border-0" type="submit" name="examenes_btn_parar"><i class="fas fa-stop-circle text-warning"></i></button>
                        </td>
                        </tr>
                    </form>
                    <%
                        }
                    } else {

                    %>
                    <tr>
                        <td colspan="4" class="text-center">
                            No hay exámenes en proceso en este momento
                        </td>
                    </tr>
                    <%    }
                    %>

                    <tr>
                        <td colspan="4" class="text-center h5">Exámenes desactivados</td>
                    </tr>

                    <%
                        if (examenesDesactivados.size() > 0) {
                            for (int i = 0; i < examenesDesactivados.size(); i++) {
                                Examen aux = examenesDesactivados.get(i);

                    %>
                    <form action="../controlador/controlador.jsp" method="POST">
                        <tr>
                        <input type="hidden" name="idExamen" value="<%= aux.getId()%>">
                        <td class="w-25">
                            <%= aux.getTitulo()%>
                        </td>
                        <td class="w-25">
                            <%= aux.getDescripcion()%>
                        </td>
                        <td class="w-25">
                            <div class="w-100">
                                <small>F. inicio:</small>
                                <small><%= aux.getFechaInicio()%></small>
                            </div>
                            <div class="w-100">
                                <small>F. fin:</small>
                                <small><%= aux.getFechaFin()%></small>
                            </div>
                        </td>
                        <td>
                            <i class="fas fa-circle text-danger"></i>
                        </td>
                        <td>
                            <button class="btn m-0 p-0 border-0" type="submit" name="examenes_btn_activar"><i class="fas fa-play-circle text-success"></i></button>
                            <button class="btn m-0 p-0 border-0" type="submit" name="examenes_btn_borrar"><i class="fas fa-trash-alt text-danger"></i></button>
                        </td>
                        </tr>
                    </form>
                    <%
                        }
                    } else {

                    %>
                    <tr>
                        <td colspan="4" class="text-center">
                            No hay exámenes desactivados en este momento
                        </td>
                    </tr>
                    <%    }
                    %>


                    <tr>
                        <td colspan="4" class="text-center h5">Exámenes finalizados</td>
                    </tr>

                    <%
                        if (examenesFinalizados.size() > 0) {
                            for (int i = 0; i < examenesFinalizados.size(); i++) {
                                Examen aux = examenesFinalizados.get(i);

                    %>
                    <form action="../controlador/controlador.jsp" method="POST">
                        <tr>
                        <input type="hidden" name="idExamen" value="<%= aux.getId()%>">
                        <td class="w-25">
                            <%= aux.getTitulo()%>
                        </td>
                        <td class="w-25">
                            <%= aux.getDescripcion()%>
                        </td>
                        <td class="w-25">
                            <div class="w-100">
                                <small>F. inicio:</small>
                                <small><%= aux.getFechaInicio()%></small>
                            </div>
                            <div class="w-100">
                                <small>F. fin:</small>
                                <small><%= aux.getFechaFin()%></small>
                            </div>
                        </td>
                        <td>
                            <i class="fas fa-circle text-primary"></i>
                        </td>
                        <td>
                            <button class="btn m-0 p-0 border-0" type="submit" name="examenes_btn_corregir"><i class="fas fa-tasks text-primary"></i></button>
                        </td>
                        </tr>
                    </form>
                    <%
                        }
                    } else {

                    %>
                    <tr>
                        <td colspan="4" class="text-center">
                            No hay exámenes finalizados en este momento
                        </td>
                    </tr>
                    <%    }
                    %>


                    <tr class="mt-5">
                        <td colspan="4" class="text-center h5">Exámenes corregidos</td>
                    </tr>

                    <%
                        if (examenesCorregidos.size() > 0) {
                            for (int i = 0; i < examenesCorregidos.size(); i++) {
                                Examen aux = examenesCorregidos.get(i);

                    %>
                    <form action="../controlador/controlador.jsp" method="POST">
                        <tr>
                        <input type="hidden" name="idExamen" value="<%= aux.getId()%>">
                        <td class="w-25">
                            <%= aux.getTitulo()%>
                        </td>
                        <td class="w-25">
                            <%= aux.getDescripcion()%>
                        </td>
                        <td class="w-25">
                            <div class="w-100">
                                <small>F. inicio:</small>
                                <small><%= aux.getFechaInicio()%></small>
                            </div>
                            <div class="w-100">
                                <small>F. fin:</small>
                                <small><%= aux.getFechaFin()%></small>
                            </div>
                        </td>
                        <td>
                            <i class="fas fa-circle text-warning"></i>
                        </td>
                        <td>
                            <button class="btn m-0 p-0 border-0" type="submit" name="examenes_btn_ver"><i class="fas fa-eye text-info"></i></button>
                        </td>
                        </tr>
                    </form>
                    <%
                        }
                    } else {

                    %>
                    <tr>
                        <td colspan="4" class="text-center">
                            No hay exámenes corregidos en este momento
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
