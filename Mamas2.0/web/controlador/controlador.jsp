<%
    
    if (request.getParameter("login") != null) {
        response.sendRedirect("../Vistas/login.jsp");
    }
    
    if (request.getParameter("registro") != null) {
        response.sendRedirect("../Vistas/registro.jsp");
    }
    
%>