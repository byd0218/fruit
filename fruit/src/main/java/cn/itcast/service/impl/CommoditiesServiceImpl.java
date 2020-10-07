package cn.itcast.service.impl;

import cn.itcast.dao.AccessoryDao;
import cn.itcast.dao.CommoditiesDao;
import cn.itcast.dao.MiddleDao;
import cn.itcast.domain.*;
import cn.itcast.service.CommoditiesService;
import cn.itcast.vo.CommodityVO;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service("commoditiesService")
public class CommoditiesServiceImpl implements CommoditiesService {

    @Autowired
    private CommoditiesDao commoditiesDao;

    @Autowired
    private MiddleDao middleDao;

    @Autowired
    private AccessoryDao accessoryDao;

    /**
     * 只是测试用过，以下内容已经写在了合同的ServiceImpl中
     * @param contractId
     * @return
     */
    @Override
    public List<CommodityVO> getVOsByContractId(Integer contractId) {
        List<Middle> middles = middleDao.getByContractId(contractId);
        List<CommodityVO> commodityVOList = new ArrayList<>();

        for (Middle middle : middles) {
            CommodityVO commodityVO = new CommodityVO();
            commodityVO.setContractid(contractId);

            commodityVO.setNumber(middle.getNumber());

            Commodities commodities = commoditiesDao.getById(middle.getFruitid());
            commodityVO.setFruitid(commodities.getFruitid());
            commodityVO.setLocality(commodities.getLocality());
            commodityVO.setName(commodities.getName());
            commodityVO.setPrice(commodities.getPrice());

            List<Accessory> accessoryList = accessoryDao.findAccessory(middle.getFruitid());
            commodityVO.setAccessoryList(accessoryList);

            commodityVOList.add(commodityVO);
        }
        return commodityVOList;
    }

    @Override
    public List<Commodities> findCommodities(Map map,int page,int size) {
        /*参数pageNum是页码值，参数pageSize代表是每页显示条数，
         必须是调用方法之前，中间不能有别的语句，否则分页就废掉了*/
        PageHelper.startPage(page,size);
        return commoditiesDao.findCommodities(map);
    }

    @Override
    public List<Commodities> findAllCommodities(int page,int size) {
        /*参数pageNum是页码值，参数pageSize代表是每页显示条数，
        必须是调用方法之前，中间不能有别的语句，否则分页就废掉了*/
        PageHelper.startPage(page,size);
        return commoditiesDao.findAllCommodities();

    }

    @Override
    public void addCommodities(Commodities commodities) {
        commoditiesDao.addCommodities(commodities);
    }

    @Override
    public void delCommodities(Integer fruitid) {
        commoditiesDao.delCommodities(fruitid);
    }

    @Override
    public void updateCommodities(Commodities commodities) {
        commoditiesDao.updateCommodities(commodities);
    }
}
