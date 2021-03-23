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
        <title>Registro</title>
    </head>
    <body class="bg-dark-blue text-white">
        <div class="row d-flex justify-content-center m-0" style="height: 100vh;">
            <div class="col-6 align-self-center">
                <div class="bg-white text-dark text-center p-5 rounded">
                    <h1 class="m-0">Registro</h1>
                    <form class="text-start" action="../controlador/controlador.jsp" name="form_registro" method="POST">
                        <div class="row my-4">
                            <div class="col-12">
                                <strong>Nombre</strong>
                                <input class="form-control" type="text" name="name_registro" placeholder="Nombre" required>
                            </div>
                        </div>
                        <div class="row my-4">
                            <div class="col-12">
                                <strong>Apellidos</strong>
                                <input class="form-control" type="text" name="surname_registro" placeholder="Apellidos" required>
                            </div>
                        </div>
                        <div class="row my-4">
                            <div class="col-12">
                                <strong>Email</strong>
                                <input class="form-control" type="text" name="email_registro" placeholder="Introduce tu email" required>
                            </div>
                        </div>
                        <div class="row my-4">
                            <div class="col-12">
                                <strong>Contraseña</strong>
                                <input class="form-control" type="password" name="passwd_registro" placeholder="Introduce tu contraseña" required>
                            </div>
                        </div>
                        <input class="btn btn-outline-success w-100 mb-4" type="submit" name="btn_registro" value="Registrar">
                        <a href="../index.jsp">Volver a home</a>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/all.min.js"></script>
</html>
