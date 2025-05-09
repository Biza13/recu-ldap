<%-- 
    Document   : index.jsp
    Created on : 8 may 2024, 9:00:27
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
                color: #333;
            }

            /*Estilo para el div que contiene todo*/
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

            /*Estilo para el h1*/
            h1 {
                text-align: center;
                color: #0e0e0e;
            }

            /*Estilo para el formulario*/
            form {
                width: 40%;
                margin: auto;
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
            
            /*Centrar la caja del texto y el boton*/
            .texto, .boton{
                text-align: center;
            }

            /*Estilo para el boton*/
            input[type="submit"] {
                background-color: black;
                color: white;
                cursor: pointer;
                border-radius: 8px;
            }

        </style>
    </head>
    <body>
        <div class="contenedora">
            <h1>Bienvenido, escriba su nombre para empezar la sesión.</h1>
            <form action="menu" method="post">
                <div class="texto">
                    <input type="text" name="nombre">
                </div>
                <br>
                <div class="boton">
                    <input type="submit" value="Comenzar">
                </div>
            </form>
        </div>
    </body>
</html>
