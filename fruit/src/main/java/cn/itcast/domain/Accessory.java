package cn.itcast.domain;

import java.io.Serializable;
import java.util.Date;

public class Accessory implements Serializable {
    private Integer accessoryid;
    private String fruitid;
    private String name;
    private String price;
    private Date createtime;
    private String ctime;

    //基于附属品，与商品一对一
    private Commodities commodities;

    public Commodities getCommodities() {
        return commodities;
    }

    public void setCommodities(Commodities commodities) {
        this.commodities = commodities;
    }

    public Integer getAccessoryid() {
        return accessoryid;
    }

    public void setAccessoryid(Integer accessoryid) {
        this.accessoryid = accessoryid;
    }

    public String getFruitid() {
        return fruitid;
    }

    public void setFruitid(String fruitid) {
        this.fruitid = fruitid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
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
        return "Accessory{" +
                "accessoryid=" + accessoryid +
                ", fruitid='" + fruitid + '\'' +
                ", name='" + name + '\'' +
                ", price='" + price + '\'' +
                ", createtime=" + createtime +
                ", ctime='" + ctime + '\'' +
                ", commodities=" + commodities +
                '}';
    }
}
