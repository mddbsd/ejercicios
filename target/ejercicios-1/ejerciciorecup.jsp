<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
                Class.forName("com.mysql.jdbc.Driver");
                String consulta1 = "SELECT nom_curs FROM tb_curs";
                Connection conexion = null;
                PreparedStatement consultaEjercicio = null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/cfl414", "root", "");
                    consultaEjercicio = conexion.prepareStatement(consulta1);
                    ResultSet listaEjercicio = consultaEjercicio.executeQuery();
                    %><ul><%
                    while(listaEjercicio.next()){
                        out.print("<li>" + listaEjercicio.getString("nom_curs") + "</li>");
                    }
                    %></ul><%
                    
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                    out.println(consultaEjercicio + "</br>");
                } finally {
                    try {
                        consultaEjercicio.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
    </body>
</html>
