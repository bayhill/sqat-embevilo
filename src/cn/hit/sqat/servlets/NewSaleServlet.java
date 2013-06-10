package cn.hit.sqat.servlets;


import cn.hit.sqat.beans.CityBean;
import cn.hit.sqat.beans.GunSmithBean;
import cn.hit.sqat.dao.CityDAO;
import cn.hit.sqat.dao.GunSmithDAO;
import cn.hit.sqat.dao.SalesDAO;
import cn.hit.sqat.login.Login;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Emil
 * Date: 2013-06-07
 * Time: 12:04
 * To change this template use File | Settings | File Templates.
 */
@WebServlet("/newsale")
public class NewSaleServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String gunsmithId = request.getParameter("gunsmith");
        String salesman = Login.getUserAuthentication(request.getSession()).getUserId();
        int city = Integer.parseInt(request.getParameter("city"));
        Date date = parseDate(request);
        Map<Integer, Integer> partQuantities = new HashMap<Integer, Integer>();
        int lockAmount = Integer.parseInt(request.getParameter("locks"));
        int stockAmount = Integer.parseInt(request.getParameter("stocks"));
        int barrellAmount = Integer.parseInt(request.getParameter("barrells"));
        partQuantities.put(400, lockAmount);
        partQuantities.put(401, stockAmount);
        partQuantities.put(402, barrellAmount);
        boolean success = SalesDAO.createNewSale(salesman, gunsmithId, city, new java.sql.Date(date.getTime()), partQuantities);
        if (success) {
            request.setAttribute("result", "success");
        } else {
            request.setAttribute("result", "fail");
        }
        List<GunSmithBean> gunsmiths = GunSmithDAO.getGunSmiths();
        List<CityBean> cities = CityDAO.getCities();
        request.setAttribute("gunsmiths", gunsmiths);
        request.setAttribute("cities", cities);
        request.getRequestDispatcher("/WEB-INF/newsale.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<GunSmithBean> gunsmiths = GunSmithDAO.getGunSmiths();
        List<CityBean> cities = CityDAO.getCities();
        request.setAttribute("gunsmiths", gunsmiths);
        request.setAttribute("cities", cities);
        request.getRequestDispatcher("/WEB-INF/newsale.jsp").forward(request, response);
    }

    public Date parseDate(HttpServletRequest request) {
        final SimpleDateFormat dateFormat = new SimpleDateFormat("MMMMMMMMMM yyyy", Locale.US);
        final String viewDateString = request.getParameter("datepicker");

        Date viewDate;
        if (viewDateString == null)
            viewDate = new Date();
        else {
            try {
                viewDate = dateFormat.parse(viewDateString);
            } catch (final ParseException e) {
                viewDate = new Date();
            }
        }
        return viewDate;
    }
}
