package cn.itcast.vo;

import cn.itcast.domain.Accessory;
import cn.itcast.domain.Commodities;

import java.io.Serializable;
import java.util.List;

public class CommodityVO implements Serializable {

    //将要展示的货物信息、附属品信息、以及数量封装到CommodityVO类中
    private Integer contractid;
    private Integer fruitid;
    private String name;
    private Double price;       //保留两位小数
    private String locality;
    private List<Accessory> accessoryList;
    private Integer number;

    private Commodities commodities;

    public Commodities getCommodities() {
        return commodities;
    }

    public void setCommodities(Commodities commodities) {
        this.commodities = commodities;
    }

    public Integer getContractid() {
        return contractid;
    }

    public void setContractid(Integer contractid) {
        this.contractid = contractid;
    }

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

    public List<Accessory> getAccessoryList() {
        return accessoryList;
    }

    public void setAccessoryList(List<Accessory> accessoryList) {
        this.accessoryList = accessoryList;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "CommodityVO{" +
                "contractid=" + contractid +
                ", fruitid=" + fruitid +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", locality='" + locality + '\'' +
                ", accessoryList=" + accessoryList +
                ", number=" + number +
                ", commodities=" + commodities +
                '}';
    }
}
