<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Modelo.Pregunta"%>
<%
    //**************************************************************************
    //********** Ventana crear pregunta - Seleccion tipo de pregunta ***********
    //**************************************************************************
    if (request.getParameter("select_tipo_pregunta") != null) {
        String tipo = request.getParameter("select_tipo_pregunta");
        switch (tipo) {
            case "Texto":
                session.setAttribute("tipo", tipo);
                response.sendRedirect("../Vistas/crearPreguntas.jsp");
                break;
            case "Numerica":
                session.setAttribute("tipo", tipo);
                response.sendRedirect("../Vistas/crearPreguntas.jsp");
                break;
            case "Una opcion":
                session.setAttribute("tipo", tipo);
                response.sendRedirect("../Vistas/crearPreguntas.jsp");
                break;
            case "Varias opciones":
                session.setAttribute("tipo", tipo);
                response.sendRedirect("../Vistas/crearPreguntas.jsp");
                break;
        }
    }

    //**************************************************************************
    //******** Ventana crear pregunta - Formulario crear preguntasa ************
    //**************************************************************************
    if (request.getParameter("btn_crearPregunta") != null) {
        if (session.getAttribute("tipo") != null) {
            String tipo = String.valueOf(session.getAttribute("tipo"));
            String descripcion = "";
            String respuestaCorrecta = "";
            Pregunta aux = null;
            switch (tipo) {
                case "Texto":
                    descripcion = request.getParameter("descripcion");
                    respuestaCorrecta = request.getParameter("resp_correcta_texto");
                    aux = new Pregunta(tipo, descripcion, respuestaCorrecta, "", "", "", respuestaCorrecta);
                    if (ConexionEstatica.crearPregunta(aux)) {
                        response.sendRedirect("../Vistas/crearPreguntas.jsp");
                    }
                    break;
                case "Numerica":
                    descripcion = request.getParameter("descripcion");
                    respuestaCorrecta = request.getParameter("resp_correcta_numerica");
                    aux = new Pregunta(tipo, descripcion, respuestaCorrecta, "", "", "", respuestaCorrecta);
                    if (ConexionEstatica.crearPregunta(aux)) {
                        response.sendRedirect("../Vistas/crearPreguntas.jsp");
                    }
                    break;
                case "Una opcion":
                    descripcion = request.getParameter("descripcion");
                    respuestaCorrecta = request.getParameter("opcion");
                    String respuestaValida_A = request.getParameter("resp_a");
                    String respuestaValida_B = request.getParameter("resp_b");
                    String respuestaValida_C = request.getParameter("resp_c");
                    String respuestaValida_D = request.getParameter("resp_d");
                    switch (respuestaCorrecta) {
                        case "opc_a":
                            aux = new Pregunta(tipo, descripcion, respuestaValida_A, respuestaValida_B, respuestaValida_C, respuestaValida_D, respuestaValida_A);
                            break;
                        case "opc_b":
                            aux = new Pregunta(tipo, descripcion, respuestaValida_A, respuestaValida_B, respuestaValida_C, respuestaValida_D, respuestaValida_B);
                            break;
                        case "opc_c":
                            aux = new Pregunta(tipo, descripcion, respuestaValida_A, respuestaValida_B, respuestaValida_C, respuestaValida_D, respuestaValida_C);
                            break;
                        case "opc_d":
                            aux = new Pregunta(tipo, descripcion, respuestaValida_A, respuestaValida_B, respuestaValida_C, respuestaValida_D, respuestaValida_D);
                            break;
                    }
                    if (ConexionEstatica.crearPregunta(aux)) {
                        response.sendRedirect("../Vistas/crearPreguntas.jsp");
                    }
                    break;
                case "Varias opciones":
                    descripcion = request.getParameter("descripcion");
                    //Miramos las opciones pulsadas
                    String respValida_CHBOX_A = request.getParameter("cboxa");
                    String respValida_CHBOX_B = request.getParameter("cboxb");
                    String respValida_CHBOX_C = request.getParameter("cboxc");
                    String respValida_CHBOX_D = request.getParameter("cboxd");

                    //Recogemos las respuestas
                    String respValida_A = request.getParameter("resp_cbox_a");
                    String respValida_B = request.getParameter("resp_cbox_b");
                    String respValida_C = request.getParameter("resp_cbox_c");
                    String respValida_D = request.getParameter("resp_cbox_d");

                    String separador = "###";
                    if (respValida_CHBOX_A != null) {
                        respuestaCorrecta = respuestaCorrecta + respValida_A + separador;
                    }
                    if (respValida_CHBOX_B != null) {
                        respuestaCorrecta = respuestaCorrecta + respValida_B + separador;
                    }
                    if (respValida_CHBOX_C != null) {
                        respuestaCorrecta = respuestaCorrecta + respValida_C + separador;
                    }
                    if (respValida_CHBOX_D != null) {
                        respuestaCorrecta = respuestaCorrecta + respValida_D + separador;
                    }

                    aux = new Pregunta(tipo, descripcion, respValida_A, respValida_B, respValida_C, respValida_D, respuestaCorrecta);

                    if (ConexionEstatica.crearPregunta(aux)) {
                        response.sendRedirect("../Vistas/crearPreguntas.jsp");
                    }
                    break;
            }
        }
    }
%>