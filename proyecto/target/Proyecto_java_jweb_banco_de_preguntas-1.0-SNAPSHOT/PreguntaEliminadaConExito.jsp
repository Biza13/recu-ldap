<%-- 
    Document   : PreguntaElimindaConExito
    Created on : 10 may 2024, 18:58:42
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

            button{
                background-color: black;
                color: white;
                border-radius: 8px;
                cursor: pointer;
            }
            
            .botones {
                justify-content: center; /* Alinea los elementos horizontalmente al centro */
                display: flex;
                align-items: center;
                gap: 10px; /* Ajusta el espacio entre elementos según tus necesidades */
            }
        </style>
    </head>
    <body>
        <div class="contenedora">
            <h1>Pregunta Eliminada con exito!!</h1>
            <a href="eliminar.jsp">
                <button>Eliminar más preguntas</button>
            </a>
            <br>
            <a href="menu.jsp">
                <button>Volver al menú</button>
            </a>
        </div>
    </body>
</html>
