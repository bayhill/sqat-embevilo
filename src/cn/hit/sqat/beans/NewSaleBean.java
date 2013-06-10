package cn.hit.sqat.beans;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Emil
 * Date: 2013-06-07
 * Time: 12:07
 * To change this template use File | Settings | File Templates.
 */
public class NewSaleBean {
    public Date date;
    public String city;
    public int salesmanid, gunpartid, quantity;


    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getSalesmanid() {
        return salesmanid;
    }

    public void setSalesmanid(int salesmanid) {
        this.salesmanid = salesmanid;
    }

    public int getGunpartid() {
        return gunpartid;
    }

    public void setGunpartid(int gunpartid) {
        this.gunpartid = gunpartid;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
