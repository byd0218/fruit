package cn.itcast.service;

import cn.itcast.domain.Commodities;
import cn.itcast.domain.User;
import cn.itcast.vo.CommodityVO;

import java.util.List;
import java.util.Map;

public interface CommoditiesService {
    List<Commodities> findCommodities(Map map,int page,int size);

    List<Commodities> findAllCommodities(int page,int size);

    void addCommodities(Commodities commodities);

    void delCommodities(Integer fruitid);

    void updateCommodities(Commodities commodities);

    //只在测试用过
    List<CommodityVO> getVOsByContractId(Integer contractId);
}
