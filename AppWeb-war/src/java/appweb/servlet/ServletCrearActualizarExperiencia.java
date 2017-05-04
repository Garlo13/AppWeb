/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.

Author     : Adrián Cardenas, Adrián García, Daniel Lopez, David Luque, John Carlo Purihin

 */
package appweb.servlet;

import appweb.ejb.DatosUsuarioFacade;
import appweb.ejb.ExperienciaFacade;
import appweb.entity.DatosUsuario;
import appweb.entity.Experiencia;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Adrián
 */
@WebServlet(name = "ServletCrearActualizarExperiencia", urlPatterns = {"/ServletCrearActualizarExperiencia"})
public class ServletCrearActualizarExperiencia extends HttpServlet {

    @EJB
    private DatosUsuarioFacade datosUsuarioFacade;

    @EJB
    private ExperienciaFacade experienciaFacade;
    
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.text.ParseException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        DatosUsuario usuarioEnSession = (DatosUsuario) session.getAttribute("usuario");
        //-------Obteniendo valores del request---------------------------------
        String idExperiencia = (String) request.getParameter("idExperiencia");
        String stringFechaComienzo = request.getParameter("fechaComienzo");
        String stringFechaFin = request.getParameter("fechaFin");
        String empresa = request.getParameter("empresa");
        String webEmpresa = request.getParameter("webEmpresa");
        String puesto = request.getParameter("puesto");
        //-------Formateo de las fechas y creacion de las mimas-----------------
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date fechaComienzo = sdf.parse(stringFechaComienzo);
        Date fechaFin = sdf.parse(stringFechaFin);
        
        Experiencia experiencia;
        if (idExperiencia != null) { //Actualizar datos
            experiencia = this.experienciaFacade.find(new BigDecimal(idExperiencia));
            List<Experiencia> listaExperiencia = (List<Experiencia>) usuarioEnSession.getExperienciaCollection();
            int i = listaExperiencia.indexOf(experiencia);
            experiencia.setFechaComienzo(fechaComienzo);
            experiencia.setFechaFinalizacion(fechaFin);
            experiencia.setEmpresa(empresa);
            experiencia.setWebEmpresa(webEmpresa);
            experiencia.setPuesto(puesto);
            
            listaExperiencia.set(i, experiencia);
            
            usuarioEnSession.setExperienciaCollection(listaExperiencia);
            session.setAttribute("usuario", usuarioEnSession);
            this.experienciaFacade.edit(experiencia);
        } else {
            //------Creacion del estudio-------
            experiencia = this.experienciaFacade.crearExperiencia(fechaComienzo,empresa);
            experiencia.setDatosUsuarioIdUsuario(usuarioEnSession);
            //-----------Quizas estas lineas no sirvan para nada
            if (webEmpresa != null && !webEmpresa.isEmpty()) {
                experiencia.setWebEmpresa(webEmpresa);
            }
            if (fechaFin != null) {
                experiencia.setFechaFinalizacion(fechaFin);
            }
            if (puesto != null) {
                experiencia.setPuesto(puesto);
            }
            //--------------------------------------------
            this.experienciaFacade.create(experiencia);
            //------Actualizacion usuario-------------------------------------------
            List<Experiencia> listaExperiencia = (List<Experiencia>) usuarioEnSession.getExperienciaCollection();
            listaExperiencia.add(experiencia);
            usuarioEnSession.setExperienciaCollection(listaExperiencia);
            session.setAttribute("usuario", usuarioEnSession);
            this.datosUsuarioFacade.edit(usuarioEnSession);
        }

        //------Finalizamos el servlet------------------------------------------
        /*
        RequestDispatcher rd;
        rd = this.getServletContext().getRequestDispatcher("/editar.jsp");
        rd.forward(request, response);
         */
        response.sendRedirect("ServletEditar");
        
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(ServletCrearActualizarExperiencia.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(ServletCrearActualizarExperiencia.class.getName()).log(Level.SEVERE, null, ex);
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
