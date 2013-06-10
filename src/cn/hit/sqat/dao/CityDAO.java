package cn.hit.sqat.dao;

import cn.hit.sqat.beans.CityBean;
import cn.hit.sqat.info.Database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Emil
 * Date: 2013-06-07
 * Time: 13:11
 */
public class CityDAO {
        public static List<CityBean> getCities() {
            List<CityBean> cities = new LinkedList<CityBean>();
            Database.connect();
            ResultSet rs = Database.query("SELECT cityid, name " +
                    "FROM City");
            try {
                while (rs.next()) {
                    CityBean cityBean = new CityBean();
                    cityBean.setCityid(rs.getInt(1));
                    cityBean.setName(rs.getString(2));
                    cities.add(cityBean);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            Database.disconnect();
            return cities;
        }
}
