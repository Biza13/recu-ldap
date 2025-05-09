/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import clases.Preguntas;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author serra
 */
@WebServlet(name = "Agregar", urlPatterns = {"/Agregar"})
public class AgregarServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Agregar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Agregar at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //comentar siempre la linea del procesRequest sino no sigue el codigo
        //processRequest(request, response);

        //creamos la sesion
        HttpSession session = request.getSession();

        request.setCharacterEncoding("UTF-8");

        ArrayList<String> posiblesResp = new ArrayList<String>();

        //Introducimos en el arraylist que sera el de las posibles respuestas todas las respuestas obligatorias.
        posiblesResp.add(request.getParameter("r1"));
        posiblesResp.add(request.getParameter("r2"));
        posiblesResp.add(request.getParameter("r3"));

        //Ifs para que en caso de no agregar respuestas en el formulario no añada al arrayList parametros vacios
        //basicamente en el if estamos diciendo que si respuesta4 NO esta vacio que agregue la respuesta y en caso de estar vacio no se agregara al arrayList
        String respuesta4 = request.getParameter("r4");
        if (!respuesta4.isEmpty()) {
            posiblesResp.add(respuesta4);
        }

        String respuesta5 = request.getParameter("r5");
        if (!respuesta5.isEmpty()) {
            posiblesResp.add(respuesta5);
        }

        //Creacion de la pregunta 
        Preguntas preguntaAAñadir = new Preguntas(request.getParameter("enunciado"), posiblesResp, request.getParameter("correcta"));

        //meter en la variable conexion la conexion subida a la session
        Connection conexion = (Connection) session.getAttribute("conexion");
        //si la conexion no es null entrara a insertar
        if (conexion != null) {
            try {
                //el forname solo carga el driver
                Class.forName("com.mysql.jdbc.Driver");
                
                //creo las variables de cada uno de los campos de la tabla para meterlos en la sentencia insert into
                String enunciado = request.getParameter("enunciado");
                String resp1 = request.getParameter("r1");
                String resp2 = request.getParameter("r2");
                String resp3 = request.getParameter("r3");
                String resp4 = request.getParameter("r4");
                String resp5 = request.getParameter("r5");
                String respCorr = request.getParameter("correcta");

                //preparar la declaracion sql para la inserccion la cual llamaremos insertar
                PreparedStatement insertar = conexion.prepareStatement("INSERT INTO preguntas (enunciado, posiblesResp1, posiblesResp2, posiblesResp3, posiblesResp4, posiblesResp5, respCorrecta) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?);");

                //asignamos los valores para cada uno de los interrogantes de la sentencia insert into, el numero corresponde con el sitio del interrogante
                insertar.setString(1, enunciado);
                insertar.setString(2, resp1);
                insertar.setString(3, resp2);
                insertar.setString(4, resp3);
                insertar.setString(5, resp4);
                insertar.setString(6, resp5);
                insertar.setString(7, respCorr);

                //ejecutamos la inserccion en la bd, lo que hace es devolver un entero, que es el numero de filas insertadas
                insertar.executeUpdate();

                //cerrar la conexion
                //conexion.close();
                //hay que meter en el catch las dos excepciones que se pueden dar 
            } catch (ClassNotFoundException | SQLException ex) {
                Logger.getLogger(AgregarServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
        //redirecionamos a la pagina de añadida con exito
        response.sendRedirect("PreguntaAnadidaConExito.jsp");
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
