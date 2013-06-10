package cn.hit.sqat.dao;

import cn.hit.sqat.beans.GunSmithBean;
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
 * Time: 13:06
 * To change this template use File | Settings | File Templates.
 */
public class GunSmithDAO {

    public static List<GunSmithBean> getGunSmiths() {
        List<GunSmithBean> gunsmiths = new LinkedList<GunSmithBean>();
        Database.connect();
        ResultSet rs = Database.query("SELECT gunsmithid, name " +
                "FROM Gunsmith");
        try {
            while (rs.next()) {
                GunSmithBean gunsmithBean = new GunSmithBean();
                gunsmithBean.setGunsmithid(rs.getInt(1));
                gunsmithBean.setName(rs.getString(2));
                gunsmiths.add(gunsmithBean);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        Database.disconnect();
        return gunsmiths;
    }
}
