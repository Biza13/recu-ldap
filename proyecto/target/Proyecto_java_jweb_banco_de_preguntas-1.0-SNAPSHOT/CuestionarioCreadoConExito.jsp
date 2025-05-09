<%-- 
    Document   : CuestionarioCreadoConExito
    Created on : 10 may 2024, 20:04:09
    Author     : serra
--%>

<%@page import="clases.Cuestionario"%>
<%@page import="clases.Preguntas"%>
<%@page import="java.util.ArrayList"%>
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
                background-color: white;
                color: #000000;
                border-radius: 8px;
                cursor: pointer;
            }
            
            input[type="submit"]{
                background-color: black;
                color: white;
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
            <h1>Cuestionario</h1>
            <%
                //bajar el array del cuestionario
                Cuestionario c = (Cuestionario) session.getAttribute("cuestionario");

                //creo variable para almacenar el tamaño del array del cuestionario, otra para almacenar el enunciado de la pregunta y otra para almacenas las respuestas
                int cantPreg;
                cantPreg = c.getBateriaPreg().size();

                String enunciado;
                ArrayList<String> respuestas = new ArrayList<>();

                //el \" es para que coja las comillas coo String
                out.println("<form action=\"ResultadosCuestionario.jsp\" method=\"post\">");

                //inicializo una variable contador para que para cada grupo de respuestas cambie el name del radio
                int cont = 0;

                for (int i = 0; i < cantPreg; i++) {
                    enunciado = c.getBateriaPreg().get(i).getEnunciado();
                    respuestas = c.getBateriaPreg().get(i).getPosiblesResp();

                    //crear variables strings par almacenar las posibles respuestas
                    String resp1 = respuestas.get(0);
                    String resp2 = respuestas.get(1);
                    String resp3 = respuestas.get(2);

                    out.println("<b>Enunciado:</b><br>" + enunciado + "<br>");

                    //for para recorrer el array de las posibles respuestas, para poder escoger un radio de cada pregunta, si no haces este for, solo te dejara coger una respuesta para todo el cuestionario
                    //mostrar pregunta y las respuestas
                    out.println("a <input type=\"radio\" name=\"respuestas" + cont + "\" value=\"a\">" + resp1 + "<br>");
                    out.println("b <input type=\"radio\" name=\"respuestas" + cont + "\" value=\"b\">" + resp2 + "<br>");
                    out.println("c <input type=\"radio\" name=\"respuestas" + cont + "\" value=\"c\">" + resp3 + "<br>");
                    //ifs para que solo si la pregunta contiene 4 o 5 respuestas las muestre
                    if (!respuestas.get(3).isEmpty()) {
                        String resp4 = respuestas.get(3);
                        out.println("d <input type=\"radio\" name=\"respuestas" + cont + "\" value=\"d\">" + resp4 + "<br>");
                        if (!respuestas.get(4).isEmpty()) {
                            String resp5 = respuestas.get(4);
                            out.println("e <input type=\"radio\" name=\"respuestas" + cont + "\" value=\"e\">" + resp5 + "<br>");
                        }
                    }
                    out.println("--------------------------------------------------------------------------------------------<br><br>");

                    //incrementamos la variable contador para que el name del radio pase al siguiente
                    cont++;
                }

                //boton para enviar las respuestas y cerrar el formulario
                out.println("<input type=\"submit\" value=\"Enviar respuestas\">");
                out.println("</form>");

            %>
        </div>
    </body>
</html>
