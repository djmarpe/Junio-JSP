<%@page import="Modelo.PreguntaAux"%>
<%@page import="Modelo.Pregunta"%>
<%@page import="Modelo.ConexionEstatica"%>
<%@page import="Modelo.Examen"%>
<%@page import="java.util.LinkedList"%>
<%@page import="Modelo.Persona"%>
<%
    if (request.getParameter("agregarExamen") != null) {
        //Recogemos los datos del profesor
        Persona aux = (Persona) session.getAttribute("usuarioLogin");
        int idProfesor = aux.getId();

        //Recogemos los datos que forman el examen
        LinkedList preguntas = new LinkedList();
        String tituloExamen = request.getParameter("tituloExamen");
        String descripcionExamen = request.getParameter("descripcionExamen");
        preguntas.add(request.getParameter("preguntaTipoTexto"));
        preguntas.add(request.getParameter("preguntaTipoNumerica"));
        preguntas.add(request.getParameter("preguntaTipoUnaOpcion"));
        preguntas.add(request.getParameter("preguntaTipoVariasOpciones"));

        //Creamos el examen
        Examen ex = new Examen("NULL", idProfesor, "default", "default", 0, tituloExamen, descripcionExamen);
        if (ConexionEstatica.addExamen(ex)) {
            int idExamen = ConexionEstatica.getIdExamen(idProfesor, tituloExamen, descripcionExamen);
            for (int i = 0; i < preguntas.size(); i++) {
                String pregun = String.valueOf(preguntas.get(i));
                int idPregunta = ConexionEstatica.getIdPregunta(pregun);
                ConexionEstatica.asignarPreguntasExamen(idExamen, idPregunta);
            }

            LinkedList preguntasDisponibles = ConexionEstatica.getPreguntas();

            session.removeAttribute("tipoTexto");
            session.removeAttribute("tipoNumerica");
            session.removeAttribute("tipoUnaOpcion");
            session.removeAttribute("tipoVariasOpciones");

            LinkedList tipoTexto = new LinkedList();
            LinkedList tipoNumerica = new LinkedList();
            LinkedList tipoUnaOpcion = new LinkedList();
            LinkedList tipoVariasOpciones = new LinkedList();

            for (int i = 0; i < preguntasDisponibles.size(); i++) {
                PreguntaAux p = (PreguntaAux) preguntasDisponibles.get(i);

                switch (p.getTipo()) {
                    case "Texto":
                        tipoTexto.add(p);
                        session.setAttribute("tipoTexto", tipoTexto);
                        break;
                    case "Numerica":
                        tipoNumerica.add(p);
                        session.setAttribute("tipoNumerica", tipoNumerica);
                        break;
                    case "Una Opcion":
                        tipoUnaOpcion.add(p);
                        session.setAttribute("tipoUnaOpcion", tipoUnaOpcion);
                        break;
                    case "Varias opciones":
                        tipoVariasOpciones.add(p);
                        session.setAttribute("tipoVariasOpciones", tipoVariasOpciones);
                        break;

                }
            }
            response.sendRedirect("../Vistas/crearExamen.jsp");
        }
    }
%>
