package cn.itcast.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Contract implements Serializable {
    private Integer contractid;  //合同ID
    private String barcode;     //合同号
    private Integer type;
    private String retailerid;  //零售商ID
    private Date createtime;
    private String ctime;

    //基于合同，与零售商为一对一
    private Retailer retailer;

    //合同与商品(货物)，多对多
    private List<Commodities> commoditiesList;

    public Retailer getRetailer() {
        return retailer;
    }

    public void setRetailer(Retailer retailer) {
        this.retailer = retailer;
    }

    public String getCtime() {
        return ctime;
    }

    public void setCtime(String ctime) {
        this.ctime = ctime;
    }

    public List<Commodities> getCommoditiesList() {
        return commoditiesList;
    }

    public void setCommoditiesList(List<Commodities> commoditiesList) {
        this.commoditiesList = commoditiesList;
    }

    public Integer getContractid() {
        return contractid;
    }

    public void setContractid(Integer contractid) {
        this.contractid = contractid;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getRetailerid() {
        return retailerid;
    }

    public void setRetailerid(String retailerid) {
        this.retailerid = retailerid;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Contract{" +
                "contractid='" + contractid + '\'' +
                ", barcode='" + barcode + '\'' +
                ", type=" + type +
                ", retailerid='" + retailerid + '\'' +
                ", createtime=" + createtime +
                ", ctime='" + ctime + '\'' +
                ", retailer=" + retailer +
                ", commoditiesList=" + commoditiesList +
                '}';
    }
}
