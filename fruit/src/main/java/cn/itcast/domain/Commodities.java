package cn.itcast.domain;

import java.io.Serializable;
import java.util.Date;

public class Commodities implements Serializable {
    private Integer fruitid;
    private String name;
    private Double price;       //保留两位小数
    private String locality;
    private Date createtime;
    private String ctime;

    public Integer getFruitid() {
        return fruitid;
    }

    public void setFruitid(Integer fruitid) {
        this.fruitid = fruitid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getLocality() {
        return locality;
    }

    public void setLocality(String locality) {
        this.locality = locality;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getCtime() {
        return ctime;
    }

    public void setCtime(String ctime) {
        this.ctime = ctime;
    }

    @Override
    public String toString() {
        return "Commodities{" +
                "fruitid=" + fruitid +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", locality='" + locality + '\'' +
                ", createtime=" + createtime +
                ", ctime='" + ctime + '\'' +
                '}';
    }
}
