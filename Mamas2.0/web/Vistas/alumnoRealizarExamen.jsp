<%-- 
    Document   : panelProfesor.jsp
    Created on : 16-mar-2021, 19:21:57
    Author     : alejandro
--%>

<%@page import="Modelo.PreguntaAux"%>
<%@page import="Modelo.Pregunta"%>
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
        <title>Realizar examen</title>
    </head>
    <body class="bg-dark-blue text-white">
        <%
            Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
            Examen examen = (Examen) session.getAttribute("examen");
            LinkedList preguntasExamen = (LinkedList) session.getAttribute("preguntasExamen");
            LinkedList respuestasExamen = (LinkedList) session.getAttribute("respuestasExamen");
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

        <div class="row bg-white m-3">
            <div class="col-12">
                <h3 class="text-dark text-center my-3"><%= examen.getTitulo()%></h3>
                <form action="../controlador/controladorAlumno.jsp" method="POST">
                    <%
                        for (int i = 0; i < preguntasExamen.size(); i++) {
                            PreguntaAux aux = (PreguntaAux) preguntasExamen.get(i);
                            Pregunta respuesta = (Pregunta) respuestasExamen.get(i);
                            switch (aux.getTipo()) {
                                case "Texto":
                    %>
                    <fieldset class="text-dark border p-3 my-3">
                        <caption>Pregunta 1</caption>
                        <h5 class="text-dark"><%= aux.getDescripcion()%></h5>
                        <textarea name="respuesta" rows="5" class="form-control" placeholder="Respuesta a la pregunta"></textarea>
                    </fieldset>
                    <%
                            break;
                        case "Numerica":
                    %>
                    <fieldset class="text-dark border p-3 my-3">
                        <caption>Pregunta 2</caption>
                        <h5 class="text-dark"><%= aux.getDescripcion()%></h5>
                        <input type="number" name="respuesta"class="form-control" placeholder="Respuesta a la pregunta">
                    </fieldset>
                    <%
                            break;
                        case "Una opcion":
                    %>
                    <fieldset class="text-dark border p-3 my-3">
                        <caption>Pregunta 3</caption>
                        <h5 class="text-dark"><%= aux.getDescripcion()%></h5>
                        <div class="w-100 text-center">
                            <input type="radio" class="mr-2" id="resp_opc_a" name="respuesta" value="<%= respuesta.getRespuesta1()%>">
                            <input type="text" name="resp_a" value="<%= respuesta.getRespuesta1()%>" readonly>
                            <input type="radio" class="ml-2" id="resp_opc_b" name="respuesta" value="<%= respuesta.getRespuesta2()%>">
                            <input type="text" name="resp_b" value="<%= respuesta.getRespuesta2()%>" readonly>
                        </div>
                        <div class="w-100 text-center mt-2">
                            <input type="radio" class="mr-2" id="resp_opc_c" name="respuesta" value="<%= respuesta.getRespuesta3()%>">
                            <input type="text" name="resp_c" value="<%= respuesta.getRespuesta3()%>" readonly>
                            <input type="radio" class="ml-2" id="resp_opc_d" name="respuesta" value="<%= respuesta.getRespuesta4()%>">
                            <input type="text" name="resp_d" value="<%= respuesta.getRespuesta4()%>" readonly>
                        </div>
                    </fieldset>
                    <%
                            break;
                        case "Varias opciones":
                    %>
                    <fieldset class="text-dark border p-3 my-3">
                        <caption>Pregunta 4</caption>
                        <h5 class="text-dark"><%= aux.getDescripcion()%></h5>
                        <div class="text-center">
                            <div class="w-100">
                                <input type="checkbox" id="cbox2" value="<%= respuesta.getRespuesta1()%>" name="respuesta"> <label for="cbox2"><%= respuesta.getRespuesta1()%></label>
                                <input type="checkbox" id="cbox2" value="<%= respuesta.getRespuesta2()%>" name="respuesta"> <label for="cbox2"><%= respuesta.getRespuesta2()%></label>
                            </div>
                            <div class="w-100">
                                <input type="checkbox" id="cbox2" value="<%= respuesta.getRespuesta3()%>" name="respuesta"> <label for="cbox2"><%= respuesta.getRespuesta3()%></label>
                                <input type="checkbox" id="cbox2" value="<%= respuesta.getRespuesta4()%>" name="respuesta"> <label for="cbox2"><%= respuesta.getRespuesta4()%></label>
                            </div>
                        </div>
                    </fieldset>
                    <%
                                    break;
                            }
                        }
                    %>
                    <input type="submit" class="btn btn-outline-success my-3" name="send_examen" value="Enviar examen">
                    <a href="../controlador/controladorAlumno.jsp?return=return" class="btn btn-outline-warning my-3">Volver</a>
                </form>
            </div>
        </div>


    </body>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/all.min.js"></script>
</html>
