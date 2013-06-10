package cn.hit.sqat.servlets;

import cn.hit.sqat.beans.ProductionBean;
import cn.hit.sqat.dao.ProductionDAO;
import cn.hit.sqat.login.Login;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Emil
 * Date: 2013-06-07
 * Time: 11:04
 * To change this template use File | Settings | File Templates.
 */
@WebServlet("/production")
public class ProductionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       //NO-OP
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<ProductionBean> partsList;
        partsList = ProductionDAO.getParts(Login.getUserAuthentication(request.getSession()).getUserId());
        request.setAttribute("production", partsList);
        request.getRequestDispatcher("/WEB-INF/production.jsp").forward(request, response);
    }
}
