package cn.itcast.service.impl;

import cn.itcast.dao.*;
import cn.itcast.domain.*;
import cn.itcast.service.ContractService;
import cn.itcast.vo.CommodityVO;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Service("contractService")
public class ContractServiceImpl  implements ContractService {

    @Autowired
    private ContractDao contractDao;

    @Autowired
    private MiddleDao middleDao;

    @Autowired
    private CommoditiesDao commoditiesDao;

    @Autowired
    private AccessoryDao accessoryDao;

    @Autowired
    private RetailerDao retailerDao;

    @Override
    public List<ContractVo> findAllContract(int page, int size, Map map) {
        PageHelper.startPage(page, size);
        List<ContractVo> contractVoList =  contractDao.findAllContract(map);
        for (ContractVo contractVo1:contractVoList){
            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = fmt.format(contractVo1.getCreatetime());
            contractVo1.setCtime(date);
//            System.out.println(contract);
        }
        return contractVoList;
    }

    /**
     * 根据合同的contractid删除合同，包括删除合同表和中间表中包含有要删除合同的相关信息
     * @param contractid
     */
    @Override
    public void delContract(Integer contractid) {

        //删除合同表的该合同的信息
        contractDao.delContract(contractid);
        //同时删除中间表的该合同的信息
        middleDao.delContract(contractid);
    }

    /**
     * 根据合同contractid获取该合同的信息与零售商（一对一）的信息
     * @param contractid
     * @return
     */
    @Override
    public Contract getContractDetail(Integer contractid) {
        Contract contract =  contractDao.getContractDetail(contractid);
        SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String s = sf.format(contract.getCreatetime());
        contract.setCtime(s);
        return contract;
    }

    @Override
    public List<Contract> getContractCommodities(Integer contractid) {
        List<Contract> contractList = contractDao.getContractCommodities(contractid);
        return contractList;
    }

    @Override
    public List<CommodityVO> commodityVOList(Integer contractid){
        //创建一个CommodityVO类型的空列表，用来存放多个commodityVO对象
        List<CommodityVO> commodityVOList = new ArrayList<>();

        //根据传入的合同contractid，查出中间表对象，放入List<Middle>中
        List<Middle> middleList = middleDao.getByContractId(contractid);
        for (Middle middle:middleList){
            //遍历middle对象列表，每遍历一个，创建一个CommodityVO空对象
            CommodityVO commodityVO = new CommodityVO();
            //将每次遍历出的合同contractid和数量，赋值给commodityVO对象的属性
            commodityVO.setContractid(middle.getContractid());
            commodityVO.setNumber(middle.getNumber());
            //根据每次遍历出的货物id(fruitid),查出所对应的货物commodities对象
            Commodities commodities = commoditiesDao.getById(middle.getFruitid());
            //将commodities对象中的具体属性赋值给CommodityVO对象的属性
            commodityVO.setFruitid(commodities.getFruitid());
            commodityVO.setName(commodities.getName());
            commodityVO.setPrice(commodities.getPrice());
            commodityVO.setLocality(commodities.getLocality());

            //根据每次遍历出的货物id(fruitid),查出所对应的附属品对象列表，因为货物commodities（及水果）与附属品是一对多的关系
            List<Accessory> accessoryList = accessoryDao.findAccessory(middle.getFruitid());
            //将附属品对象列表accessoryList，赋值给commodityVO对象
            commodityVO.setAccessoryList(accessoryList);

            //此时将每一个个实例化后的commodityVO对象添加到commodityVOList中
            commodityVOList.add(commodityVO);
        }
        return commodityVOList;
    }

    /**
     * 添加合同时，点击关联，查询出启用的零售商
     * @param map
     * @return
     */
    @Override
    public List<Retailer> getAllRetailer(Map map) {
        return retailerDao.findAllRetailer(map);
    }

    @Override
    public List<Commodities> getAllCommodities(Map map) {
        return commoditiesDao.findCommodities(map);
    }

    /**
     * 根据水果id获取该水果的附属品信息
     * @param fruitid
     * @return
     */
    @Override
    public List<Accessory> getAllAccessory(Integer fruitid) {
        return accessoryDao.findAccessory(fruitid);
    }

    /**
     * 添加合同
     * @param contract
     * @param type1
     * @param commoditiesIdArrays
     * @param numberArrays
     */
    @Override
    public void addOneContract(Contract contract,String type1,String[] commoditiesIdArrays,String[] numberArrays) {
        Integer type = Integer.parseInt(type1);
        contract.setType(type);
        contract.setCreatetime(new Date());
        contractDao.addOneContract(contract);
        //获取插入操作后该记录的id
        System.out.println(contract.getContractid());

        //遍历水果commoditiesIdArrays，同时遍历numberArrays，将每一条插入中间表，这样点击合同详情时相应的水果及附属品信息就会存在
        for (int j= 0;j<numberArrays.length;j++){
            System.out.println(numberArrays[j]);
            System.out.println(commoditiesIdArrays[j]);

            Integer number = Integer.parseInt(numberArrays[j]);
            Integer fruitid = Integer.parseInt(commoditiesIdArrays[j]);

            Middle middle = new Middle();
            middle.setContractid(contract.getContractid());
            middle.setFruitid(fruitid);
            middle.setNumber(number);
            middleDao.addMiddle(middle);
        }
    }

    /**
     * 编辑合同
     * @param contract
     * @param type1
     * @param commoditiesIdArrays
     * @param numberArrays
     */
    @Override
    public void editContract(Contract contract, String type1, String[] commoditiesIdArrays, String[] numberArrays) {
        //根据contractid先修改合同表
        Integer type = Integer.parseInt(type1);
        contract.setType(type);
        contract.setCreatetime(new Date());
        contractDao.editContract(contract);
        //先删除中间表中含有该合同contractid的记录
        middleDao.delContract(contract.getContractid());

        //遍历水果commoditiesIdArrays，同时遍历numberArrays，将每一条更新后的合同信息插入中间表，这样点击合同详情时相应的水果及附属品信息就会刷新
        for (int j= 0;j<numberArrays.length;j++){
            System.out.println(numberArrays[j]);
            System.out.println(commoditiesIdArrays[j]);

            Integer number = Integer.parseInt(numberArrays[j]);
            Integer fruitid = Integer.parseInt(commoditiesIdArrays[j]);

            Middle middle = new Middle();
            middle.setContractid(contract.getContractid());
            middle.setFruitid(fruitid);
            middle.setNumber(number);
            middleDao.addMiddle(middle);
        }
    }

    @Override
    public List<Contract> isExitContract(Integer retailerid) {
        return contractDao.isExitContract(retailerid);
    }
}
