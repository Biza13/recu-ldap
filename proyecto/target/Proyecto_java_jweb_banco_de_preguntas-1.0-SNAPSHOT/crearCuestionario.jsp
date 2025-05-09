<%-- 
    Document   : crearCuestionario.jsp
    Created on : 8 may 2024, 9:20:54
    Author     : serra
--%>

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
            
            input[type="submit"]{
                background-color: black;
                color: white;
                border-radius: 8px;
            }
            
            input[type="number"], textarea{
                border-radius: 8px;
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
            <h1>Creación del cuestionario</h1>
            <b>De cuantas preguntas quieres que cuente el cuestionario?</b>
            <br><br>
            <form action="CrearCuestionario" method="post">
                <input type="number" name="cantPreg">
                <br><br>
                <input type="submit" value="Enviar peticion">
            </form>
        </div>
    </body>
</html>
