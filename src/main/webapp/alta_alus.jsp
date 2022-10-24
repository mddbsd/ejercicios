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
        <link rel="stylesheet" href="./css/gal_css.css" />
        <link rel="stylesheet" href="./css/sidebar_css.css" />
        <link rel="stylesheet" href="./css/bootstrap.min.css">
     
        <title>Listado de cursos</title>
    </head>
    <script src="./js/sidebar_js.js"></script>
    <body>
        <div id="mySidenav" class="sidenav">
          <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
          <a href="#">About</a>
          <a href="#">Services</a>
          <a href="#">Clients</a>
          <a href="#">Contact</a>
        </div>
          <!-- Use any element to open the sidenav -->
          <span onclick="openNav()">abrir</span>

          <!-- Add all page content inside this div if you want the side nav to push page content to the right (not used if you only want the sidenav to sit on top of the page -->
        <div id="main">
                <form id="alta" method="post" action="alta_alus_op.jsp">
                    nombre<input type="text" name="nombre" /></br>
                    dni<input type="text" name="dni" /></br> 
                    <input type="submit" value="Aceptar" />
                </form>
                curso<select name="cursos" id="curs" form="alta">
                        
                <%
                Class.forName("com.mysql.jdbc.Driver");
                String selectCurs = "SELECT nom_curs FROM curs";               
                Connection conexion = null;
                PreparedStatement consultaCursos = null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba1", "root", "");
                    consultaCursos = conexion.prepareStatement(selectCurs);
                    ResultSet listaCursos = consultaCursos.executeQuery();
                    while (listaCursos.next()) {
                       out.print("<option value='"+listaCursos.getString("nom_curs")+"'>"+listaCursos.getString("nom_curs")+"</option>");
                    }
                    
                    listaCursos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                    //out.println(consultaHorarios + "</br>");
                    out.println(consultaCursos + "</br>");
                } finally {
                    try {        
                        consultaCursos.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
                    </select>

        </div>
        
    </body>
</html>