<%-- 
    Document   : crearPreguntas
    Created on : 23-mar-2021, 12:07:29
    Author     : alejandro
--%>

<%@page import="Modelo.Persona"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../css/all.min.css">
        <link rel="stylesheet" type="text/css" href="../css/miCss.css">
        <title>Crear preguntas</title>
    </head>
    <body class="bg-dark-blue text-white">
        <%
            Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
            if(session.getAttribute("tipo")==null){
                session.setAttribute("tipo", "Texto");
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
                        <a class="navbar-brand text-dark" href="../controlador/controlador.jsp?crearExamen=crearExamen">
                            Crear examen
                        </a>
                        <a class="navbar-brand text-dark text-decoration-underline" href="crearPreguntas.jsp">
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
            <div class="row m-3 bg-white">
                <div class="col-12 text-center text-dark">
                    <div class="row m-3">
                        <div class="col-12 text-center text-dark">
                            <form action="../controlador/controladorCrearPreguntas.jsp" name="form_select_tipo_pregunta">
                                <strong>Seleccione el tipo de pregunta</strong>
                                <select name="select_tipo_pregunta" class="form-control w-25 d-inline" onchange="this.form.submit()">
                                    <%
                                        if (session.getAttribute("tipo") != null) {
                                            String tipo = String.valueOf(session.getAttribute("tipo"));
                                            switch (tipo) {
                                                case "Texto":
                                    %>
                                    <option selected>Texto</option>
                                    <option>Numerica</option>
                                    <option>Una opcion</option>
                                    <option>Varias opciones</option>
                                    <%
                                            break;
                                        case "Numerica":
                                    %>
                                    <option>Texto</option>
                                    <option selected>Numerica</option>
                                    <option>Una opcion</option>
                                    <option>Varias opciones</option>
                                    <%
                                            break;
                                        case "Una opcion":
                                    %>
                                    <option>Texto</option>
                                    <option>Numerica</option>
                                    <option selected>Una opcion</option>
                                    <option>Varias opciones</option>
                                    <%
                                            break;
                                        case "Varias opciones":
                                    %>
                                    <option>Texto</option>
                                    <option>Numerica</option>
                                    <option>Una opcion</option>
                                    <option selected>Varias opciones</option>
                                    <%
                                                break;
                                        }

                                    } else {
                                    %>
                                    <option selected>Texto</option>
                                    <option>Numerica</option>
                                    <option>Una opcion</option>
                                    <option>Varias opciones</option>
                                    <%
                                        }
                                    %>
                                </select>
                            </form>
                        </div>
                    </div>
                                <form action="../controlador/controladorCrearPreguntas.jsp" method="POST" name="form_preguntas">
                        <div class="row m-3">
                            <div class="col-12 text-center text-dark">
                                <strong class="d-block">Descripción de la pregunta</strong>
                                <textarea name="descripcion" rows="5" class="w-50"></textarea>
                            </div>
                        </div>
                        <%
                            if (session.getAttribute("tipo") != null) {
                                String tipo = String.valueOf(session.getAttribute("tipo"));
                                switch (tipo) {
                                    case "Texto":
                        %>
                        <div class="row m-3">
                            <div class="col-12 text-center text-dark">
                                <strong class="d-block">Respuesta</strong>
                                <textarea name="resp_correcta_texto" rows="5" class="w-50"></textarea>
                            </div>
                        </div>
                        <%
                                break;
                            case "Numerica":
                        %>
                        <div class="row m-3">
                            <div class="col-12 text-center text-dark">
                                <strong class="d-block">Respuesta</strong>
                                <input type="number" name="resp_correcta_numerica" rows="5" class="w-50">
                            </div>
                        </div>
                        <%
                                break;
                            case "Una opcion":
                        %>
                        <div class="row m-3">
                            <div class="col-12 text-center text-dark">
                                <div class="w-100 text-center">
                                    <strong class="d-block">Seleccione la respuesta correcta</strong>
                                    <input type="radio" class="mr-2" id="resp_opc_a" name="opcion" value="opc_a">
                                    <input type="text" name="resp_a">
                                    <input type="radio" class="ml-2" id="resp_opc_b" name="opcion" value="opc_b">
                                    <input type="text" name="resp_b">
                                </div>
                                <div class="w-100 text-center mt-2">
                                    <input type="radio" class="mr-2" id="resp_opc_c" name="opcion" value="opc_c">
                                    <input type="text" name="resp_c">
                                    <input type="radio" class="ml-2" id="resp_opc_d" name="opcion" value="opc_d">
                                    <input type="text" name="resp_d">
                                </div>
                            </div>
                        </div>
                        <%
                                break;
                            case "Varias opciones":
                        %>
                        <div class="row m-3">
                            <div class="col-12 text-center text-dark">
                                <div class="w-100 text-center">
                                    <strong class="d-block">Seleccione las respuestas correctas</strong>
                                    <label class="mr-2"><input type="checkbox" id="cboxa" name="cboxa">
                                        <input type="text" name="resp_cbox_a"></label>
                                    <label class="ml-2"><input type="checkbox" id="cboxb" name="cboxb">
                                        <input type="text" name="resp_cbox_b"></label>
                                </div>
                                <div class="w-100 text-center mt-2">
                                    <label class="mr-2"><input type="checkbox" id="cboxc" name="cboxc">
                                        <input type="text" name="resp_cbox_c"></label>
                                    <label class="ml-2"><input type="checkbox" id="cboxd" name="cboxd">
                                        <input type="text" name="resp_cbox_d"></label>
                                </div>
                            </div>
                        </div>
                        <%
                                    break;
                            }
                        } else {
                        %>
                        <div class="row m-3">
                            <div class="col-12 text-center text-dark">
                                <strong class="d-block">Respuesta</strong>
                                <textarea name="resp_correcta_texto" rows="5" class="w-50"></textarea>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <div class="row m-3">
                            <div class="col-12 text-center text-dark">
                                <input type="submit" name="btn_crearPregunta" class="btn btn-outline-success" value="Crear pregunta">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </body>
    <script src="js/bootstrap.min.js"></script>
</html>
