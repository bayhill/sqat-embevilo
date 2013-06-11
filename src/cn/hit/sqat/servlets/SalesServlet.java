package cn.hit.sqat.servlets;

import cn.hit.sqat.dao.SalesDAO;
import cn.hit.sqat.login.Login;
import cn.hit.sqat.login.UserType;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

@WebServlet("/sm_sales")
public class SalesServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = Login.getUserAuthentication(request.getSession()).getUserId();
        UserType userType = Login.getUserAuthentication(request.getSession()).getUserType();
        java.sql.Date date = new java.sql.Date(parseDate(request).getTime());
        if(userType == UserType.SALESMAN) {
            List<cn.hit.sqat.beans.SalesBean> lockSalesList = SalesDAO.getSales(userType, userId, 400, date);
            List<cn.hit.sqat.beans.SalesBean> stockSalesList = SalesDAO.getSales(userType, userId, 401, date);
            List<cn.hit.sqat.beans.SalesBean> barrellSalesList = SalesDAO.getSales(userType, userId, 402, date);
            List<Integer> lockSalesTotal = SalesDAO.getSalesTotal(userId, 400, date);
            List<Integer> stockSalesTotal = SalesDAO.getSalesTotal(userId, 401, date);
            List<Integer> barrellSalesTotal = SalesDAO.getSalesTotal(userId, 402, date);
            List<Integer> salesTotal = SalesDAO.getSalesTotal(userId, 0, date);
            request.setAttribute("locksales", lockSalesList);
            request.setAttribute("stocksales", stockSalesList);
            request.setAttribute("barrellsales", barrellSalesList);
            request.setAttribute("locksalestotal", lockSalesTotal);
            request.setAttribute("stocksalestotal", stockSalesTotal);
            request.setAttribute("barrellsalestotal", barrellSalesTotal);
            request.setAttribute("salestotal", salesTotal);
            request.getRequestDispatcher("/WEB-INF/sm_sales.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = Login.getUserAuthentication(request.getSession()).getUserId();
        UserType userType = Login.getUserAuthentication(request.getSession()).getUserType();
        if(userType == UserType.SALESMAN) {
            List<cn.hit.sqat.beans.SalesBean> lockSalesList = SalesDAO.getSales(userType, userId, 400, new Date());
            List<cn.hit.sqat.beans.SalesBean> stockSalesList = SalesDAO.getSales(userType, userId, 401, new Date());
            List<cn.hit.sqat.beans.SalesBean> barrellSalesList = SalesDAO.getSales(userType, userId, 402, new Date());
            List<Integer> lockSalesTotal = SalesDAO.getSalesTotal(userId, 400, new Date());
            List<Integer> stockSalesTotal = SalesDAO.getSalesTotal(userId, 401, new Date());
            List<Integer> barrellSalesTotal = SalesDAO.getSalesTotal(userId, 402, new Date());
            List<Integer> salesTotal = SalesDAO.getSalesTotal(userId, 0, new Date());
            request.setAttribute("locksales", lockSalesList);
            request.setAttribute("stocksales", stockSalesList);
            request.setAttribute("barrellsales", barrellSalesList);
            request.setAttribute("locksalestotal", lockSalesTotal);
            request.setAttribute("stocksalestotal", stockSalesTotal);
            request.setAttribute("barrellsalestotal", barrellSalesTotal);
            request.setAttribute("salestotal", salesTotal);
            request.getRequestDispatcher("/WEB-INF/sm_sales.jsp").forward(request, response);
        } else {
            List<cn.hit.sqat.beans.SalesBean> salesList;
            salesList = SalesDAO.getSales(userType, userId, new Date());
            request.setAttribute("sales", salesList);
            request.getRequestDispatcher("/WEB-INF/sm_sales.jsp").forward(request, response);
        }
    }

    public Date parseDate(HttpServletRequest request) {
        final SimpleDateFormat dateFormat = new SimpleDateFormat("MMMMMMMMMM yyyy", Locale.US);
        final String viewDateString = request.getParameter("datepicker");

        Date viewDate;
        if(viewDateString == null)
            viewDate = new Date();
        else {
            try {
                viewDate = dateFormat.parse(viewDateString);
            } catch(final ParseException e) {
                viewDate = new Date();
            }
        }
        return viewDate;
    }
}
