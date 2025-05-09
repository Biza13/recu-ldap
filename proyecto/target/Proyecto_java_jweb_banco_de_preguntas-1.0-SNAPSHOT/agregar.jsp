<%-- 
    Document   : agregar.jsp
    Created on : 8 may 2024, 9:11:26
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
                background:#ccffff;
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
            
            input[type="text"], textarea{
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
            <h1>Agregar preguntas</h1>

            <form action="Agregar" method="post">
                <b>Enunciado.</b>
                <br>
                <textarea name="enunciado" placeholder="Escriba su pregunta" cols="100" rows="10" required></textarea>
                <br><br>

                <b>Respuestas posibles (mínimo 3 obligatoriamente, máximo 5).</b>
                <br>
                <i>Respuesta a obligada.</i>
                <input type="text" name="r1" required>
                <br><br>
                <i>Respuesta b obligada.</i>
                <input type="text" name="r2" required>
                <br><br>
                <i>Respuesta c obligada.</i>
                <input type="text" name="r3" required>
                <br><br>
                <i>Respuesta d opcional.</i>
                <input type="text" name="r4">
                <br><br>
                <i>Respuesta e opcional.</i>
                <input type="text" name="r5">
                <br><br>

                <b>Escriba la respuesta correcta, escribiendo el caracter correspondiente.</b>
                <br>
                <input type="text" name="correcta" required>
                <br><br>

                <input type="submit" value="Añadir pregunta">
                <br><br>
            </form>  
        </div>
    </body>
</html>
