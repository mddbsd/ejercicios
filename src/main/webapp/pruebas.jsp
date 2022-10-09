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
                String maxIdCurso = "SELECT MAX(id_curs) AS id FROM tb_curs";
                String consulta1 = "INSERT INTO tb_curs(nom_curs, desc_curs) VALUES (?,?)";
                String consulta2 = "INSERT INTO tb_horarios()";
                Connection conexion = null;
                PreparedStatement consultaPreparada = null;   
                int id = 0;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/cfl414", "root", "");
                    consultaPreparada = conexion.prepareStatement(maxIdCurso);
                    ResultSet a = consultaPreparada.executeQuery();
                    a.next();
                    id = Integer.parseInt(a.getString("id"));
                    out.print(id);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.print(" exepcion ");
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