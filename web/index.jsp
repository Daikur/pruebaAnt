<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String nombre = "";
            Connection conexion;
            try {              
                InitialContext initCtx = new InitialContext();
                Context envCtx = (Context) initCtx.lookup("java:comp/env");
                DataSource dataSource = (DataSource) envCtx.lookup("jdbc/despliegue");
                conexion = dataSource.getConnection(); //Obtener la conexión del pool
                String sql = "Select nombre from usuarios";
                PreparedStatement psNombre = conexion.prepareStatement(sql);
                ResultSet rs = psNombre.executeQuery();
                rs.next();
                nombre = rs.getString("nombre");
                conexion.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        %>
        <h1>Nombre cohete: <%=nombre%> </h1>
    </body>
</html>
