package cn.itcast.dao;

import cn.itcast.domain.Commodities;
import cn.itcast.domain.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface CommoditiesDao {
    public List<Commodities> findCommodities(Map map);
    public void addCommodities(Commodities commodities);
    public void delCommodities(Integer fruitid);
    public void updateCommodities(Commodities commodities);

    public List<Commodities> findAllCommodities();

    Commodities getById(Integer fruitid);
}
