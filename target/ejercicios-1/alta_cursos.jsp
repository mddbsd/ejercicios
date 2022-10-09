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
        <h1>CURSOS</h1>
        <ul>
            <%
                Class.forName("com.mysql.jdbc.Driver");
                String insert = "INSERT INTO tb_curs(nom_curs, desc_curs, inscriptos) VALUES (?,?,0)";
                String select = "select * from tb_curs";
                Connection conexion = null;
                PreparedStatement consultaPreparada = null;
                int fila = 999;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/cfl414", "root", "");
                    consultaPreparada = conexion.prepareStatement(insert);
                    consultaPreparada.setString(1, request.getParameter("curso"));
                    consultaPreparada.setString(2, request.getParameter("desc"));
                    fila = consultaPreparada.executeUpdate();
                    out.print("<a href='muestra_cursos.jsp'>Curso cargado existosamente</a>");                   

                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                    out.println(consultaPreparada + "</br>");
                    out.println("parametro curso: " + request.getParameter("curso"));
                    out.println("parametro desc: " + request.getParameter("desc"));
                    out.println("parametro fila: " + fila);
                } finally {
                    try {
                        consultaPreparada.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                } 
           %>
        </ul>
    </body>
</html>