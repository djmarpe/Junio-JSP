<%-- 
    Document   : crearPreguntas
    Created on : 23-mar-2021, 12:07:29
    Author     : alejandro
--%>

<%@page import="Modelo.PreguntaAux"%>
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
        <title>Crear examen</title>
    </head>
    <body class="bg-dark-blue text-white">
        <%
            Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
            LinkedList tipoTexto = null;
            LinkedList tipoNumerica = null;
            LinkedList tipoUnaOpcion = null;
            LinkedList tipoVariasOpciones = null;
            if (session.getAttribute("tipoTexto") != null) {
                tipoTexto = (LinkedList) session.getAttribute("tipoTexto");
            }
            if (session.getAttribute("tipoNumerica") != null) {
                tipoNumerica = (LinkedList) session.getAttribute("tipoNumerica");
            }
            if (session.getAttribute("tipoUnaOpcion") != null) {
                tipoUnaOpcion = (LinkedList) session.getAttribute("tipoUnaOpcion");
            }
            if (session.getAttribute("tipoVariasOpciones") != null) {
                tipoVariasOpciones = (LinkedList) session.getAttribute("tipoVariasOpciones");
            }
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
            <div class="row m-3 bg-white">
                <div class="col-12" id="menu-list">
                    <div class="navbar m-0 p-2 navbar-brand ">
                        <a class="navbar-brand text-dark text-decoration-underline" href="../controlador/controlador.jsp?crearExamen=crearExamen">
                            Crear examen
                        </a>
                        <a class="navbar-brand text-dark" href="crearPreguntas.jsp">
                            Crear preguntas
                        </a>
                        <a class="navbar-brand text-dark" href="../controlador/controlador.jsp?adminExamenes=adminExamenes">
                            Admin. examenes
                        </a>
                        <a class="navbar-brand text-dark" href="../controlador/controlador.jsp?adminAlumnos=adminAlumnos">
                            Admin. usuarios
                        </a>
                    </div>
                </div>
            </div>

            <div class="row m-3 bg-white d-flex justify-content-center">
                <div class="col-12 col-md-8">
                    <form action="../controlador/controladorCrearExamen.jsp" method="POST">
                        <h1 class="text-dark text-center">Crear examen</h1>
                        <input type="text" name="tituloExamen" placeholder="Titulo del examen" class="form-control my-2">
                        <textarea name="descripcionExamen" placeholder="El examen consta de ..." class="form-control my-2"></textarea>
                        <fieldset class="my-4">
                            <h5 class="text-dark">Pregunta 1.&nbsp;<small class="text-muted">(Pregunta de tipo texto)</small></h5>
                            <%
                                if (tipoTexto != null) {
                            %>
                            <select name="preguntaTipoTexto" class="form-control-lg w-100">
                                <%
                                    for (int i = 0; i < tipoTexto.size(); i++) {
                                        PreguntaAux aux = (PreguntaAux) tipoTexto.get(i);
                                %>
                                <option><%= aux.getDescripcion()%></option>
                                <%
                                    }
                                %>
                            </select>
                            <%
                            } else {
                            %>
                            <p class="text-dark text-center">No hay preguntas de tipo texto en estos momentos</p>
                            <%
                                }
                            %>
                        </fieldset>
                        <fieldset class="my-4">
                            <h5 class="text-dark">Pregunta 2.&nbsp;<small class="text-muted">(Pregunta de tipo numérico)</small></h5>
                            <%
                                if (tipoNumerica != null) {
                            %>
                            <select  name="preguntaTipoNumerica" class="form-control-lg w-100">
                                <% for (int i = 0; i < tipoNumerica.size(); i++) {
                                        PreguntaAux aux = (PreguntaAux) tipoNumerica.get(i);
                                %>
                                <option><%= aux.getDescripcion()%></option>
                                <%
                                    }
                                %>
                            </select>
                            <%
                            } else {
                            %>
                            <p class="text-dark text-center">No hay preguntas de tipo numericas en estos momentos</p>
                            <%
                                }
                            %>

                        </fieldset>
                        <fieldset class="my-4">
                            <h5 class="text-dark">Pregunta 3.&nbsp;<small class="text-muted">(Pregunta de una sola opción)</small></h5>
                            <%
                                if (tipoUnaOpcion != null) {
                            %>
                            <select name="preguntaTipoUnaOpcion" class="form-control-lg w-100">
                                <% for (int i = 0; i < tipoUnaOpcion.size(); i++) {
                                        PreguntaAux aux = (PreguntaAux) tipoUnaOpcion.get(i);
                                %>
                                <option><%= aux.getDescripcion()%></option>
                                <%
                                    }
                                %>
                            </select>
                            <%
                            } else {
                            %>
                            <p class="text-dark text-center">No hay preguntas de una sola opción en estos momentos</p>
                            <%
                                }
                            %>

                        </fieldset>
                        <fieldset class="my-4">
                            <h5 class="text-dark">Pregunta 4.&nbsp;<small class="text-muted">(Pregunta de varias opciones)</small></h5>
                            <%
                                if (tipoVariasOpciones != null) {
                            %>
                            <select name="preguntaTipoVariasOpciones" class="form-control-lg w-100">
                                <% for (int i = 0; i < tipoVariasOpciones.size(); i++) {
                                        PreguntaAux aux = (PreguntaAux) tipoVariasOpciones.get(i);
                                %>
                                <option><%= aux.getDescripcion()%></option>
                                <%
                                    }
                                %>
                            </select>
                            <%
                            } else {
                            %>
                            <p class="text-dark text-center">No hay preguntas de varias opciones en estos momentos</p>
                            <%
                                }
                            %>

                        </fieldset>
                        <%
                            if (tipoTexto == null || tipoNumerica == null || tipoUnaOpcion == null || tipoVariasOpciones == null) {
                        %>
                        <input class="mb-4 btn btn-outline-success" type="submit" name="agregarExamen" value="Crear Examen" disabled>
                        <%
                        } else {
                        %>  
                        <input class="mb-4 btn btn-outline-success" type="submit" name="agregarExamen" value="Crear Examen">
                        <%
                            }
                        %>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script src="js/bootstrap.min.js"></script>
</html>
