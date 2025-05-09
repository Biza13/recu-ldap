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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
@WebServlet(name = "Eliminar", urlPatterns = {"/Eliminar"})
public class EliminarServlet extends HttpServlet {

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
            out.println("<title>Servlet Eliminar</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Eliminar at " + request.getContextPath() + "</h1>");
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
        //comentar siempre esta linea
        //processRequest(request, response);

        request.setCharacterEncoding("UTF-8");

        //para importar el array de preguntas del servlet de añadir, creamos la sesion otra vez
        HttpSession session = request.getSession();

        //creo variable para almacenar el id de la pregunta a eliminar que nos han dado en el formulario y le hago el parseInt ya que lo que nos devuelve es un string
        int preguntaEliminar = Integer.parseInt(request.getParameter("id"));

        //cogemos la conexion de la sesion
        Connection conexion = (Connection) session.getAttribute("conexion");

        if (conexion != null) {
            try {
                //creo variable para almacenar sentencia delete donde a parte pondre la variable anteriormente creada para obtener el valor del id de la pregunta a eliminar
                String delete = "delete from preguntas where id=" + preguntaEliminar;

                //Esta sentencia sql basicamente nos devuelve una fila si el id existe en la BD si no, no devolvera nada
                String selectId = "select count(*) from preguntas where id=" + preguntaEliminar;

                //statement con la sentencia del select count
                PreparedStatement selectCount = conexion.prepareStatement(selectId);

                //guardamos el resultado del select en el resultSet
                ResultSet resultSet = selectCount.executeQuery();

                /*condicion para ver si el resultSet ha devuelto algo y en caso de que si, obviamente habra una fila si el numero de id 
                introducido por el usuario existe, asi que pondremos que sea mayor a 0*/
                //el.next() devuelve true si hay otra fila
                if (resultSet.next() && resultSet.getInt(1) > 0) {
                    //crear el objeto preparedStatment para ejecutar la sentencia
                    PreparedStatement borrar = conexion.prepareStatement(delete);

                    //ejecutamos la sentencia
                    borrar.executeUpdate();

                    //redirecionamos a la pagina de borrado con exito
                    response.sendRedirect("PreguntaEliminadaConExito.jsp");
                } else {
                    // El ID no existe, redireccionar a la página de error
                    response.sendRedirect("ErrorPreguntaNoEncontrada.jsp");
                }
                //capturamos la excepcion de la conexion
            } catch (SQLException ex) {
                Logger.getLogger(EliminarServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

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
