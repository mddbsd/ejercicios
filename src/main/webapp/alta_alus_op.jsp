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
                String insertAlu = "INSERT INTO alus (apyn, dni) VALUES (?,?)"; 
                String insertRel = "INSERT INTO alus_curs (id_alus, id_curs) VALUES "
                                   + "((SELECT id_alus FROM alus WHERE dni=?),"
                                   + "(SELECT id_curs FROM curs WHERE nom_curs=?))";
                Connection conexion = null;
                PreparedStatement consultaAlus = null;
                PreparedStatement consultaRel = null;
                String apyn = request.getParameter("nombre");
                String dni = request.getParameter("dni");
                String curso = request.getParameter("cursos");
                out.print(apyn + " " + dni + " " + curso);
                try {
                    
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba1", "root", "");
                    consultaAlus = conexion.prepareStatement(insertAlu);
                    consultaAlus.setString(1, apyn);
                    consultaAlus.setString(2, dni);
                    consultaAlus.execute();
                    consultaRel = conexion.prepareStatement(insertRel);
                    consultaRel.setString(1, dni);
                    consultaRel.setString(2, curso);
                    consultaRel.execute();
                    conexion.close();
                    out.print("EXITO!");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                    out.println(insertRel + "</br>");
                    out.println(insertAlu + "</br>");
                } finally {
                    try {        
                        consultaAlus.close();
                        consultaRel.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
            
    </body>
</html>
