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
        <link rel="stylesheet" href="./css/bootstrap.min.css">
        <title>Listado de cursos</title>
    </head>
    <body>
        <div class="navbar navbar-expand-lg fixed-top bavbar-dark bg-primary">
            <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
                <div class="container-fluid">
                  <a class="navbar-brand" href="#">Navbar</a>
                  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                  </button>
                  <div class="collapse navbar-collapse" id="navbarColor01">
                    <ul class="navbar-nav me-auto">
                      <li class="nav-item">
                        <a class="nav-link active" href="#">Home
                          <span class="visually-hidden">(current)</span>
                        </a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="#">Features</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="#">Pricing</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" href="#">About</a>
                      </li>
                      <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Dropdown</a>
                        <div class="dropdown-menu">
                          <a class="dropdown-item" href="#">Action</a>
                          <a class="dropdown-item" href="#">Another action</a>
                          <a class="dropdown-item" href="#">Something else here</a>
                          <div class="dropdown-divider"></div>
                          <a class="dropdown-item" href="#">Separated link</a>
                        </div>
                      </li>
                    </ul>
                    <form class="d-flex">
                      <input class="form-control me-sm-2" type="text" placeholder="Search">
                      <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
                    </form>
                  </div>
                </div>
            </nav>
        </div>
        <div class="gallary_container" style="margin: 200px 50px 20px 50px; background: magenta">
            <%
                Class.forName("com.mysql.jdbc.Driver");
                String consulta1 = "SELECT nom_curs, desc_curs, id_curs, inscriptos FROM tb_curs";
                String consultaTablaHorarios = "SELECT tb_dias.dia AS dia,"
                                              +"       tb_horarios.hr_inicio AS hr_inicio," 
                                              +"       tb_horarios.hr_fin AS hr_fin,"
                                              +"       tb_curs.desc_curs AS desc_curs,"
                                              +"       tb_curs.inscriptos AS inscriptos "
                                              +"FROM tb_horarios " 
                                              +"    JOIN tb_curs " 
                                              +"        ON tb_horarios.id_curs= tb_curs.id_curs " 
                                              +"    JOIN tb_dias " 
                                              +"        ON tb_horarios.id_dia= tb_dias.id_dia "
                                              +"    AND tb_curs.id_curs=?";
                String cDisponible = "style='color: green'";
                String cLleno = "style='color: red'";
                String cEspera = "style='color: yellow'";
                Connection conexion = null;
                PreparedStatement consultaCursos = null;
                PreparedStatement consultaHorarios = null;
                try {
                    conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/cfl414", "root", "");
                    consultaCursos = conexion.prepareStatement(consulta1);
                    ResultSet listaCursos = consultaCursos.executeQuery();
                    while (listaCursos.next()) {
                        consultaHorarios = conexion.prepareStatement(consultaTablaHorarios);
                        consultaHorarios.setString(1, listaCursos.getString("id_curs"));
                        ResultSet listaHorarios = consultaHorarios.executeQuery();
                        String color;
                        int cant = (Integer) listaCursos.getObject("inscriptos");
                        if (cant < 15){
                            color="green";                    
                        }else if (cant > 15 && cant <= 20){
                            color="yellow";
                        }else{
                            color="red";
                        }
                        out.println("<div class='image_container' style='background: " + color + "'>curso: " + listaCursos.getString("nom_curs") + "</br>");
                        out.println("detalle: " + listaCursos.getString("desc_curs") + "</br>");
                        out.println("inscriptos: " + cant + "</br>");
                        while (listaHorarios.next()){
                            out.print(listaHorarios.getString("dia") + "Inicia: " + listaHorarios.getString("hr_inicio") + "Fin: " + listaHorarios.getString("hr_fin"));
                        }
                        out.println("</div>");
                        listaHorarios.close();
                    }
                    
                    listaCursos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("exepcion </br>");
                    out.println("detalle de la consulta: </br>");
                    out.println(consultaHorarios + "</br>");
                    out.println(consultaCursos + "</br>");
                } finally {
                    try {
                        consultaHorarios.close();
                        consultaCursos.close();
                        conexion.close();
                    } catch (Exception e) {
                    }
                }
            %>
        </div>
    </body>
</html>