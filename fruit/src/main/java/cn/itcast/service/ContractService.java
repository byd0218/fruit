package cn.itcast.service;

import cn.itcast.domain.*;
import cn.itcast.vo.CommodityVO;
import org.omg.CORBA.INTERNAL;

import java.util.List;
import java.util.Map;

public interface ContractService {
    List<ContractVo> findAllContract(int page, int size, Map map);

    /**
     * 根据合同的contractid删除合同，包括删除合同表和中间表中包含有要删除合同的相关信息
     * @param contractid
     */
    void delContract(Integer contractid);

    /**
     * 根据合同contractid获取该合同的信息与零售商（一对一）的信息
     * @param contractid
     * @return
     */
    Contract getContractDetail(Integer contractid);
    List<Contract> getContractCommodities(Integer contractid);

    List<CommodityVO> commodityVOList(Integer contractid);

    /**
     * 添加合同时，点击关联，查询出启用的零售商
     * @param map
     * @return
     */
    List<Retailer> getAllRetailer(Map map);

    List<Commodities> getAllCommodities(Map map);

    List<Accessory> getAllAccessory(Integer fruitid);

    void addOneContract(Contract contract,String type1,String[] commoditiesIdArrays,String[] numberArrays);

    void editContract(Contract contract,String type1,String[] commoditiesIdArrays,
                      String[] numberArrays);
    List<Contract> isExitContract(Integer retailerid);
}
