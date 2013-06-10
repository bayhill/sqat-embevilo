package cn.hit.sqat.beans;

/**
 * Created with IntelliJ IDEA.
 * User: Emil
 * Date: 2013-06-07
 * Time: 11:05
 */
public class ProductionBean {
    private String description;
    private int gunsmithid, gunpartid, monthlylimit, price;

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public int getGunsmithid() {
        return gunsmithid;
    }

    public void setGunsmithid(int gunsmithid) {
        this.gunsmithid = gunsmithid;
    }

    public int getGunpartid() {
        return gunpartid;
    }

    public void setGunpartid(int gunpartid) {
        this.gunpartid = gunpartid;
    }

    public int getMonthlylimit() {
        return monthlylimit;
    }

    public void setMonthlylimit(int monthlylimit) {
        this.monthlylimit = monthlylimit;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }
}
