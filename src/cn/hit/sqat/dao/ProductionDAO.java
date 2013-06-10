package cn.hit.sqat.dao;

import cn.hit.sqat.beans.ProductionBean;
import cn.hit.sqat.info.Database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Emil
 * Date: 2013-06-07
 * Time: 11:12
 * To change this template use File | Settings | File Templates.
 */
public class ProductionDAO {
    public static List<ProductionBean> getParts(String gunsmith) {
        List<ProductionBean> parts = new LinkedList<ProductionBean>();
        Database.connect();
        ResultSet rs = Database.query("SELECT p.gunpartid, gp.description, p.monthlylimit, p.price " +
                "FROM Production p, Gunpart gp " +
                "WHERE p.gunsmithid = " + gunsmith + " " +
                "AND p.gunpartid = gp.gunpartid");
        try {
            while (rs.next()) {
                ProductionBean productionBean = new ProductionBean();
                productionBean.setGunpartid(rs.getInt(1));
                productionBean.setDescription(rs.getString(2));
                productionBean.setMonthlylimit(rs.getInt(3));
                productionBean.setPrice(rs.getInt(4));
                parts.add(productionBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Database.disconnect();
        return parts;
    }
}
