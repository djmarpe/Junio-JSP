<%-- 
    Document   : panelProfesor.jsp
    Created on : 16-mar-2021, 19:21:57
    Author     : alejandro
--%>

<%@page import="Modelo.ExamenAlumno"%>
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
        <title>Principal</title>
    </head>
    <body class="bg-dark-blue text-white">
        <%
            Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
            LinkedList listaExamenesProgramados = (LinkedList) session.getAttribute("listaExamenesProgramados");
            LinkedList listaExamenesCorregidos = (LinkedList) session.getAttribute("listaExamenesCorregidos");
        %>
        <div class="sticky-top bg-dark-blue py-2">
            <header class="row m-0 py-3">
                <div class="col-6 align-self-center">
                    <h3 class="m-0">Mamas 2.0</h3>
                </div>

                <div class="col-6 align-self-center">
                    <a href="../controlador/controlador.jsp?cerrarSesion=cerrarSesion" class="float-end mx-3 btn btn-danger">Cerrar sesión</a>
                </div>
            </header>
            <div class="row bg-white m-3">
                <div class="col-12 text-muted">
                    <strong>Bienvenido:&nbsp;</strong><small><%= usuarioLogin.getName() + ' ' + usuarioLogin.getSurname()%></small>
                </div>
            </div>
        </div>

        <div class="row m-3 bg-white text-dark p-3 d-flex justify-content-between">
            <div class="col-12 col-md-8 d-flex justify-content-between">

                <table class="w-100 my-5 table">
                    <tr class="m-5">
                        <th colspan="3" class="text-dark text-center h3">Exámenes programados</th>
                    </tr>
                    <tr class="m-5">
                        <th class="h3 w-auto text-center">Título</th>
                        <th class="h3 w-auto text-center">Descripción</th>
                        <th class="h3 w-auto text-center">Acciones</th>
                    </tr>
                    <%
                        if (listaExamenesProgramados != null) {
                    %>
                    <form action="../controlador/controladorAlumno.jsp" method="POST">
                        <%
                            for (int i = 0; i < listaExamenesProgramados.size(); i++) {
                                Examen programado = (Examen) listaExamenesProgramados.get(i);
                        %>
                        <tr>
                        <input type="hidden" name="idExamen" value="<%= programado.getId()%>">
                        <td class="w-auto text-center"><%= programado.getTitulo()%></td>
                        <td class="w-auto text-center"><%= programado.getDescripcion()%></td>
                        <td class="w-auto text-center">
                            <button class="btn m-0 p-0" type="submit" name="examen_realizar"><i class="fas fa-play-circle text-success"></i></button>
                        </td>
                        </tr>
                        <%
                            }
                        %>
                    </form>
                    <%
                    } else {
                    %>
                    <tr>
                        <td class="w-auto text-center" colspan="3">No hay exámenes programados</td>
                    </tr>
                    <%
                        }
                    %>

                </table>
            </div>

            <div class="col-12 col-md-3 d-flex justify-content-between">
                <table class="w-100 my-5 table">
                    <tr class="m-5">
                        <th colspan="2" class="text-dark text-center h6">Exámenes corregidos</th>
                    </tr>
                    <tr class="m-5">
                        <th class="h6 w-auto text-center">Título</th>
                        <th class="h6 w-auto text-center">Nota</th>
                    </tr>
                    <%
                        if (listaExamenesCorregidos != null) {
                            for (int i = 0; i < listaExamenesCorregidos.size(); i++) {
                                ExamenAlumno corregido = (ExamenAlumno) listaExamenesCorregidos.get(i);
                    %>
                    <tr>
                    <input type="hidden" name="idExamen" value="<%= corregido.getIdExamen()%>">
                    <td class="h6 w-auto text-center"><%= corregido.getTitulo()%></td>
                    <td  class="h6 w-auto text-center"><%= corregido.getNota()%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td class="h6 w-auto text-center" colspan="2">No hay exámenes corregidos</td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
        </div>
    </body>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/all.min.js"></script>
</html>
