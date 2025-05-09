<%-- 
    Document   : menu.jsp
    Created on : 9 may 2024, 9:50:38
    Author     : serra
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    //variables para la conexion en local
    //para el mysql de mi pc es decir en local
    //String url = "jdbc:mysql://localhost:3306/prueba";
    //String usuario = "programacion";
    //String contrasena = "programacion";

    //para lechugas
    String usuario = "begona";
    String contrasena = "usuario";
    String url = "jdbc:mysql://lechugas.ddns.net:3306/begona";

    //meter en la variable conexion la conexion subida a la session
    Connection conexion = (Connection) session.getAttribute("conexion");

    // Si no existe la conexion, crear una nueva conexión y almacenarla en la sesión
    if (conexion == null) {
        try {
            // Crear una conexión a la base de datos
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(url, usuario, contrasena);

            // Almacenar la conexión en la sesión
            session.setAttribute("conexion", conexion);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #999999;
                margin: 0;
                padding: 0;
                color: black;
            }

            .contenedora {
                width: 80%;
                margin: auto;
                overflow: hidden;
                padding: 20px;
                background: #cccccc;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin-top: 20px;
                border-radius: 8px;
            }

            h1 {
                text-align: center;
                color: #0e0e0e;
            }

            .elementosEnLinea {
                display: flex;
                align-items: center;
                gap: 10px; /* Ajusta el espacio entre elementos según tus necesidades */
            }
            .id {
                width: 30%;
                margin-right: 30px;
            }
            
            .botones{
                width: 20%;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                padding: 20px;
                text-align: center;
                margin-left: 40%;
            }
            
            button{
                background-color: black;
                color: white;
                border-radius: 8px;
                cursor: pointer;
            }

        </style>
    </head>
    <body>
        <div>
            <!--dos formas diferentes de imprimir por pantalla-->
            <!<!-- Datos de usuario y fecha y hora -->
            <div class="elementosEnLinea">
                <div class="id">
                    <b>Nombre Usuario:</b>
                    <%=session.getAttribute("nombreUsuario")%>
                </div>
                <br><br>
                <div class="id">
                    <b>Fecha:</b>
                    <%
                        out.print(session.getAttribute("fecha"));
                    %>
                </div>
                <br><br>
                <div class="id">
                    <b>Hora:</b>
                    <%
                        out.print(session.getAttribute("horaFormateada"));
                    %>
                </div>
            </div>
            <br>

            <h1>Creación de cuestionario para 1ºDAW</h1>

            <div class="botones">
                <!<!-- Botones que nos llevaran a las paginas para agregar o eliminar preguntas y para crear el cuestionario -->
                <a href="agregar.jsp">
                    <button>Agregar pregunta</button>
                </a> 
                <br><br>
                <a href="eliminar.jsp">
                    <button>Eliminar pregunta</button>
                </a> 
                <br><br>
                <a href="crearCuestionario.jsp">
                    <button>Crear cuestionario</button>
                </a> 
            </div>
        </div>
    </body>
</html>
