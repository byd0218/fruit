package cn.itcast.service.impl;

import cn.itcast.dao.ContractDao;
import cn.itcast.dao.RetailerDao;
import cn.itcast.domain.Contract;
import cn.itcast.domain.Retailer;
import cn.itcast.service.RetailerService;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("retailerService")
public class RetailerServiceImpl implements RetailerService {

    @Autowired
    private RetailerDao retailerDao;

    @Autowired
    private ContractDao contractDao;

    @Override
    public List<Retailer> findAllRetailer(Map map,int page, int size) {
        PageHelper.startPage(page, size);
        return retailerDao.findAllRetailer(map);
    }

    @Override
    public void addRetailer(Retailer retailer) {
        retailerDao.addRetailer(retailer);
    }

    @Override
    public void updateRetailer(Retailer retailer) {
        retailerDao.updateRetailer(retailer);
    }

    /**
     * 删除零售商之前判断该零售商是否有合同，有的话先删除合同，没有的话可以直接删除
     * @param retailerid
     */
    @Override
    public void delRetailer(Integer retailerid) {
        retailerDao.delRetailer(retailerid);
    }
}
