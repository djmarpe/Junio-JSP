<%@page import="Modelo.Pregunta"%>
<%@page import="Modelo.Persona"%>
<%@page import="Modelo.PreguntaAux"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Examen"%>
<%@page import="Modelo.ConexionEstatica"%>
<%
    if (request.getParameter("examen_realizar") != null) {
        int idExamen = Integer.parseInt(request.getParameter("idExamen"));

        Examen examen = ConexionEstatica.getExamen(idExamen);
        LinkedList preguntasExamen = ConexionEstatica.getPreguntasExamen(idExamen);
        LinkedList respuestasExamen = new LinkedList();

        for (int i = 0; i < preguntasExamen.size(); i++) {
            PreguntaAux aux = (PreguntaAux) preguntasExamen.get(i);
            int idPregunta = aux.getIdPregunta();
            respuestasExamen.add(ConexionEstatica.getRespuestas(idPregunta));
        }

        session.setAttribute("examen", examen);
        session.setAttribute("preguntasExamen", preguntasExamen);
        session.setAttribute("respuestasExamen", respuestasExamen);

        response.sendRedirect("../Vistas/alumnoRealizarExamen.jsp");

    }

    if (request.getParameter("send_examen") != null) {
        Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
        Examen examen = (Examen) session.getAttribute("examen");
        LinkedList preguntasExamen = (LinkedList) session.getAttribute("preguntasExamen");
        LinkedList respuestasExamen = (LinkedList) session.getAttribute("respuestasExamen");

        int idExamen = Integer.parseInt(examen.getId());
        int idAlumno = usuarioLogin.getId();

        String respuestas[] = request.getParameterValues("respuesta");

        if (ConexionEstatica.isExamen(idExamen, idAlumno)) {
            ConexionEstatica.deleteRespuestas(idExamen, idAlumno);
        }

        for (int i = 0; i < preguntasExamen.size(); i++) {
            PreguntaAux aux = (PreguntaAux) preguntasExamen.get(i);
            int idPregunta = aux.getIdPregunta();
            switch (aux.getTipo()) {
                case "Texto":
                    ConexionEstatica.addRespuesta(idExamen, idAlumno, idPregunta, respuestas[0]);
                    break;
                case "Numerica":
                    ConexionEstatica.addRespuesta(idExamen, idAlumno, idPregunta, respuestas[1]);
                    break;
                case "Una opcion":
                    ConexionEstatica.addRespuesta(idExamen, idAlumno, idPregunta, respuestas[2]);
                    break;

                case "Varias opciones":
                    for (int k = 3; k < respuestas.length; k++) {
                        ConexionEstatica.addRespuesta(idExamen, idAlumno, idPregunta, respuestas[k]);
                    }
                    break;
            }
        }
        LinkedList examanesProgramados = ConexionEstatica.getExamenesProgramados();
        LinkedList examenesCorregidos = ConexionEstatica.getExamenesCorregidos(usuarioLogin.getId());
        session.setAttribute("listaExamenesProgramados", examanesProgramados);
        session.setAttribute("listaExamenesCorregidos", examenesCorregidos);
        response.sendRedirect("../Vistas/panelAlumno.jsp");
    }

    if (request.getParameter("return") != null) {
        Persona usuarioLogin = (Persona) session.getAttribute("usuarioLogin");
        LinkedList examanesProgramados = ConexionEstatica.getExamenesProgramados();
        LinkedList examenesCorregidos = ConexionEstatica.getExamenesCorregidos(usuarioLogin.getId());
        session.setAttribute("listaExamenesProgramados", examanesProgramados);
        session.setAttribute("listaExamenesCorregidos", examenesCorregidos);
        response.sendRedirect("../Vistas/panelAlumno.jsp");
    }
%>
