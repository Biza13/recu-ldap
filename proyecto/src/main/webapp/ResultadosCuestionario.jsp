<%-- 
    Document   : EmpezarCuestionario
    Created on : 16 may 2024, 10:30:09
    Author     : serra
--%>

<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileWriter"%>
<%@page import="clases.Preguntas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="clases.Cuestionario"%>
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

            button{
                background-color: black;
                color: white;
                border-radius: 8px;
                cursor: pointer;
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
            <h1>Puntuación</h1>
            <br>

            <%
                //primero descargamos el cuestionario de la sesion
                Cuestionario c = (Cuestionario) session.getAttribute("cuestionario");

                //no creamos un array list para meter el array de las preguntas del cuestionario y poder recorrerlo
                ArrayList<Preguntas> pregCuest = new ArrayList<>();
                pregCuest = c.getBateriaPreg();

                //creamos una String para el enunciado
                String enunciado;

                //variable contador para las respuestas acertadas
                int acertadas = 0;

                //for para recorres el cuestionario y ver que preguntas ha acertado
                for (int i = 0; i < pregCuest.size(); i++) {
                    enunciado = pregCuest.get(i).getEnunciado();
                    out.println("<b>Para la pregunta: </b><br>" + enunciado + "<br>");
                    out.println("<b>La respuesta correcta es la---> </b>" + pregCuest.get(i).getRespCorrecta() + "<br>");
                    out.println("<b>Tu respuesta ha sido---> </b>" + request.getParameter("respuestas" + i) + "<br>");
                    out.println("-----------------------------------------------------------------------<br>");

                    //creo dos strings una que contendra la respuesta correcta y la otra que contendra la respuesta elegida por el usuario
                    String respuestaCorrecta = pregCuest.get(i).getRespCorrecta();
                    String respuestaUsuario = request.getParameter("respuestas" + i);

                    if (respuestaCorrecta.equals(respuestaUsuario)) {
                        acertadas++;
                    }
                }

                out.println("<h3>Has acertado " + acertadas + " preguntas de un total de " + pregCuest.size() + " .<h3>");

            %>

            <h1>Descarga aqui tu cuestionario</h1>

            <form action="DescargaServlet" method="post">
                <input type="hidden" name="rutaArchivo" value="C:/Users/serra/Downloads/cuestionario.txt">
                <button type="submit">Descargar Cuestionario</button>
                <br>
            </form>
            <br>
            <a href="menu.jsp">
                <button>Volver al menú</button>
            </a>
        </div>
    </body>
</html>
