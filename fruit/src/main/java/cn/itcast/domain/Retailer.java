package cn.itcast.domain;

import java.io.Serializable;
import java.util.Date;

public class Retailer implements Serializable {
    private Integer retailerid;
    private String name;
    private String telephone;
    private String address;
    private Integer status;
    private Date createtime;
    private String ctime;

    public String getCtime() {
        return ctime;
    }

    public void setCtime(String ctime) {
        this.ctime = ctime;
    }

    public Integer getRetailerid() {
        return retailerid;
    }

    public void setRetailerid(Integer retailerid) {
        this.retailerid = retailerid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    @Override
    public String toString() {
        return "Retailer{" +
                "retailerid=" + retailerid +
                ", name='" + name + '\'' +
                ", telephone='" + telephone + '\'' +
                ", address='" + address + '\'' +
                ", status=" + status +
                ", createtime=" + createtime +
                ", ctime='" + ctime + '\'' +
                '}';
    }
}
