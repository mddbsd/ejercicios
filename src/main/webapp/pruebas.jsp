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
                String consulta1 = "SELECT tb_curs.nom_curs AS nom_curs," 
                                  +"       tb_dias.dia AS dia," 
                                  +"       tb_horarios.hr_inicio AS hr_inicio," 
                                  +"       tb_horarios.hr_fin AS hr_fin,"
                                  +"       tb_curs.desc_curs AS desc_curs,"
                                  +"       tb_curs.inscriptos AS inscriptos "
                                  +"FROM tb_horarios " 
                                  +"    JOIN tb_curs " 
                                  +"        ON tb_horarios.id_curs= tb_curs.id_curs " 
                                  +"    JOIN tb_dias " 
                                  +"        ON tb_horarios.id_dia= tb_dias.id_dia "
                                  ;
                String cDisponible = "style='color: green'";
                String cLleno = "style='color: red'";
                String cEspera = "style='color: yellow'";
                Connection conexion = null;
                PreparedStatement consultaCursos = null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/cfl414", "root", "");
                    consultaCursos = conexion.prepareStatement(consulta1);
                    ResultSet listaCursos = consultaCursos.executeQuery();
                    while (listaCursos.next()) {
                        String color;
                        int cant = (Integer) listaCursos.getObject("inscriptos");
                        if (cant < 15){
                            color="green";                    
                        }else if ( cant > 15 && cant <= 20){
                            color="yellow";
                        }else{
                            color="red";
                        }
                        out.println("<li style='color: " + color + "'>curso: " + listaCursos.getString("nom_curs") + "</li>");
                        out.println("<p>detalle: " + listaCursos.getString("desc_curs") + "</br>");
                        out.println("<p>inscriptos: " + cant + "</br>");
                    }
                    listaCursos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    try {
                        consultaCursos.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
        </ul>
    </body>
</html>