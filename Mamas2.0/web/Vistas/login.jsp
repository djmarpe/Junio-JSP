<%-- 
    Document   : login
    Created on : 16-mar-2021, 14:09:38
    Author     : alejandro
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="../css/miCss.css">
        <title>Iniciar sesión</title>
    </head>
    <body class="bg-dark-blue text-white">
        <div class="row d-flex justify-content-center m-0" style="height: 100vh;">
            <div class="col-6 align-self-center">
                <div class="bg-white text-dark text-center p-5 rounded">
                    <h1 class="m-0">Iniciar sesión</h1>
                    <form class="text-start" action="../controlador/controlador.jsp" name="form_login" method="POST">
                        <div class="row my-4">
                            <div class="col-12">
                                <strong>Email</strong>
                                <input class="form-control" type="text" name="email_login" placeholder="introduce tu email" required>
                            </div>
                        </div>
                        <div class="row my-4">
                            <div class="col-12">
                                <strong>Contraseña</strong>
                                <input class="form-control" type="password" name="passwd_login" placeholder="Introduce tu contraseña" required>
                            </div>
                        </div>
                        <input class="btn btn-outline-success w-100" type="submit" name="login" value="Inicar sesión">
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script src="js/bootstrap.min.js"></script>
</html>
