package cn.itcast.dao;

import cn.itcast.domain.Retailer;
import org.springframework.stereotype.Repository;


import java.util.List;
import java.util.Map;

@Repository
public interface RetailerDao {
    /**
     * 1.查询所有，2.点击搜索查询（模糊查询），3.构建合同时，点击关联查询状态为启用的零售商
     * @param map
     * @return
     */
    public List<Retailer> findAllRetailer(Map map);
    public void addRetailer(Retailer retailer);
    public void updateRetailer(Retailer retailer);
    public void delRetailer(Integer retailerid);
}
