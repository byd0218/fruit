package cn.itcast.service;

import cn.itcast.domain.Retailer;

import java.util.List;
import java.util.Map;

public interface RetailerService {
    List<Retailer> findAllRetailer(Map map,int page, int size);
    void addRetailer(Retailer retailer);
    void updateRetailer(Retailer retailer);
    void delRetailer(Integer retailerid);
}
