<%-- 
    Document   : eliminar.jsp
    Created on : 8 may 2024, 9:19:30
    Author     : serra
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.Preguntas"%>
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

            /*Estilo para el div que contiene todo*/
            .contenedora {
                width: 80%;
                margin: auto;
                overflow: hidden;
                padding: 20px;
                background:#cccccc;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                margin-top: 20px;
                border-radius: 8px;
            }

            /*Estilo para el h1*/
            h1 {
                text-align: center;
                color: black;
            }

            /*Estilo para el formulario*/
            form {
                margin-top: 10px;
                padding: 20px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(10, 10, 10, 0.1);   /*sombra para la caja*/
            }

            /*Estilo para la caja del nombre*/
            input[type="text"]{
                margin: 10px 0;
                border-radius: 4px;
            }

            /*Estilo para el boton*/
            input[type="submit"] {
                background-color:#000000;
                color: white;
                cursor: pointer;
                border-radius: 8px;
            }
            
            /*Poner nombre, hora y fecha en linea*/
            .elementosEnLinea {
                display: flex;
                align-items: center;
                gap: 10px; /* Ajusta el espacio entre elementos según tus necesidades */
            }
            .id {
                width: 30%;
                margin-right: 30px;
            }

        </style>
    </head>
    <body>
        <div class="contenedora">
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
            <h1>Eliminar preguntas</h1>

            <b>¿Que pregunta desea eliminar?</b>
            <br><br>
            <%
                //esto es para que coja la codificacion de utf-8
                request.setCharacterEncoding("UTF-8");

                //coger la conexion de la sesion para poder usarla para hacer el select y mostrar las pregntas
                Connection conexion = (Connection) session.getAttribute("conexion");

                //creo variable con sentencia select para añadirsela al Resultset
                String select = "select * from preguntas";

                //se utilizará para ejecutar sentencias SQL para hacer el select y mostrar todas las preguntas
                Statement sentenciaSelect = conexion.createStatement();
                
                //en los resultset almacenamos los resultados de una consulta sql
                ResultSet listaPreguntas = sentenciaSelect.executeQuery(select);

            %>   
            <!<!-- creo una tabla para mostrar las preguntas junto con su id para poder mostrarlas y eliminarlas -->
            <table border="1">
                <tr>
                    <th>ID</th>
                    <th>Enunciado de la pregunta</th>
                </tr>
                <%while (listaPreguntas.next()) {%>
                <tr>   
                    <!-- .getInt recupera el contenido de la columna segun su tipo y entre parentesis el nombre del campo o columna -->
                    <td><% out.println(listaPreguntas.getInt("id")); %></td>
                    <td><% out.println(listaPreguntas.getString("enunciado")); %></td>
                </tr>
                <%}%>
            </table>

            <%
                //cerrar el statment y el resultset
                listaPreguntas.close();
                sentenciaSelect.close();
            %>
            <form action="Eliminar" method="post">
                <b>Escriba el id de la pregunta a eliminar</b>
                <br><br>
                <input type="text" name="id">
                <br><br>
                <input type="submit" value="Eliminar respuesta">
            </form>
        </div>
    </body>
</html>
