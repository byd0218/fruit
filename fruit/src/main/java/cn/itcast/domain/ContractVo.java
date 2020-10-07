package cn.itcast.domain;

import java.util.Date;

public class ContractVo {
    private Integer contractid;
    private String barcode;
    private Integer type;
    private String retailerName;
    private Date createtime;
    private String ctime;

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

    public String getRetailerName() {
        return retailerName;
    }

    public void setRetailerName(String retailerName) {
        this.retailerName = retailerName;
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
        return "ContractVo{" +
                "contractid=" + contractid +
                ", barcode='" + barcode + '\'' +
                ", type=" + type +
                ", retailerName='" + retailerName + '\'' +
                ", createtime=" + createtime +
                ", ctime='" + ctime + '\'' +
                '}';
    }
}
