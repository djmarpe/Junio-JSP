<%-- 
    Document   : index
    Created on : 16-mar-2021, 13:15:34
    Author     : alejandro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/miCss.css">
        <title>Home</title>
    </head>
    <body class="bg-dark-blue text-white">
        <div class="row m-5 p-5 rounded bg-white text-dark ">
            <div class="col-12">
                <div class="row">
                    <div class="col-12">
                        <h1 class="text-center m-0 my-5">Bienvenido a Mamas 2.0</h1>
                        <p>En esta plataforma educativa, tendrás la oportunidad de gestionar el seguimiento de tus cursos.</p>
                    </div>
                </div>
                <div class="row d-flex justify-content-end">
                    <div class="col-6">
                        <a href="controlador/controlador.jsp?login=login" name="goToLogin" class="btn btn-success float-end mx-1">Iniciar sesión</a>
                        <a href="controlador/controlador.jsp?registro=registro" name="goToRegistro" class="btn btn-outline-success float-end mx-1">Registro</a>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script src="js/bootstrap.min.js"></script>
</html>
