package cn.itcast.controller;

import cn.itcast.domain.*;
import cn.itcast.service.ContractService;
import cn.itcast.vo.CommodityVO;
import com.alibaba.fastjson.JSONObject;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/contract")
public class ContractController {

    @Autowired
    private ContractService contractService;

    /**
     * 点击购物合同后，需要展示的合同信息
     * @param page
     * @param size
     * @param model
     * @param contractVo
     * @param type1
     * @param startTime
     * @param endTime
     * @return
     */
    @RequestMapping("/findAllContract")
    public String findAllContract(@RequestParam(name = "page",required = true,defaultValue = "1")
                                              int page, @RequestParam(name = "size",required =
            true,defaultValue = "4") int size, Model model, ContractVo contractVo,String type1,
                                  String startTime,
                                  String endTime){
        Map<String,Object> map = new HashMap<>();
        map.put("contractid",contractVo.getContractid());
        map.put("barcode",contractVo.getBarcode());
        map.put("retailerName",contractVo.getRetailerName());
        if (type1 != null && !type1.equals("") && !type1.equals("-1")){     //符合该条件时不进行拼接类型
            Integer type = Integer.parseInt(type1);
            contractVo.setType(type);
            map.put("type",contractVo.getType());
        }
        if (startTime != null && !startTime.equals("")){
            map.put("startTime",startTime);
        }
        if (endTime != null && !endTime.equals("")){
            map.put("endTime",endTime);
        }
        System.out.println(map);
        List<ContractVo> contractVoList  = contractService.findAllContract(page, size, map);

        PageInfo pageInfo = new PageInfo(contractVoList);
        model.addAttribute("pageInfo",pageInfo.getList().size()<1?null:pageInfo);
        model.addAttribute("size",size);
        model.addAttribute("page",page);
//        model.addAttribute("barcode",contractVo.getBarcode());
        /*在第一次输入查询条件点击搜索后，再将这些值回显到框中，然后点击页的相关操作时，将这些
        * 回显值继续绑定到该查询中
        * */
        model.addAttribute("condition",map);
        model.addAttribute("type1",type1);
        model.addAttribute("startTime",startTime);
        model.addAttribute("endTime",endTime);
        return "contract/contractHome";
    }

    /**
     * 点击编辑后，根据该合同id找出需要展示的原合同的信息，展示在编辑页面中
     * @param contractid
     * @param model
     * @return
     */
    @RequestMapping("/updateContract")
    public String updateContract(Integer contractid,Model model){
        //根据合同contractid获取该合同的信息与零售商（一对一）的信息
        Contract contract = contractService.getContractDetail(contractid);
//        System.out.println(contract);
        //根据合同contractid获取该合同的货物（商品）(一对多)的信息
        List<Contract> contractList = contractService.getContractCommodities(contractid);
        Contract contract1 = contractList.get(0);

        //要展示的货物对象列表
        List<Commodities> commoditiesList = contract1.getCommoditiesList();
        model.addAttribute("commoditiesList",commoditiesList);
        model.addAttribute("contract",contract);

        /**
         * CommodityVO对象列表，已经被实例化，传到前台遍历展示即可（要展示的每一行信息（每一个CommodityVO对象））
         */
        List<CommodityVO> commodityVOList = contractService.commodityVOList(contractid);
        model.addAttribute("commodityVOList",commodityVOList);

        System.out.println(contract);
        return "contract/editContract";
    }

    /**
     * 根据合同的contractid删除合同，包括删除1.合同表2.中间表中包含有要删除合同的相关信息
     * @param page
     * @param size
     * @param model
     * @param contractid
     * @return
     */
    @RequestMapping("/delContract")
    public String delContract(@RequestParam(name = "page",required = true,defaultValue = "1")
                                          int page, @RequestParam(name = "size",required =
            true,defaultValue = "4") int size, Model model,Integer contractid){
        contractService.delContract(contractid);
        return findAllContract(page,size,model,new ContractVo(),null,null,null);
    }

    /**
     * 查询出合同详情中的信息（包括合同的，相关零售商的，货物以及附属品的信息）
     * @param contractid
     * @param model
     * @return
     */
    @RequestMapping("/getContractDetail")
    public String getContractDetail(Integer contractid,Model model){

        //根据合同contractid获取该合同的信息与零售商（一对一）的信息
        Contract contract = contractService.getContractDetail(contractid);
//        System.out.println(contract);
        //根据合同contractid获取该合同的货物（商品）(一对多)的信息
        List<Contract> contractList = contractService.getContractCommodities(contractid);
        Contract contract1 = contractList.get(0);

        //要展示的货物对象列表
        List<Commodities> commoditiesList = contract1.getCommoditiesList();
        model.addAttribute("commoditiesList",commoditiesList);
        model.addAttribute("contract",contract);

        /**
         * CommodityVO对象列表，已经被实例化，传到前台遍历展示即可（要展示的每一行信息（每一个CommodityVO对象））
         */
        List<CommodityVO> commodityVOList = contractService.commodityVOList(contractid);
        model.addAttribute("commodityVOList",commodityVOList);

        return "contract/contractDetail";
    }

    /**
     * 跳转添加合同页面
     * @param model
     * @return
     */
    @RequestMapping("/addContract")
    public String addContract(Model model){

        return "contract/addContract";
    }

    /**
     * 在编辑合同页面，点击关联，发送ajax请求获取状态为（启用）的零售商
     * @param json
     * @return
     */
    @RequestMapping("/getRetailer")
    @ResponseBody
    public  List<Retailer> getRetailer(@RequestBody String json){
        //获取json数据中key为name的值
        String name = JSONObject.parseObject(json).getString("name");
        Map<String,Object> map = new HashMap<>();
        if (name != null && name != ""){
            map.put("name",name);
        }
        //获取状态为（启用）的零售商
        map.put("status",1);
        //查询出所有状态为启用的零售商
        List<Retailer> retailerList = contractService.getAllRetailer(map);
        //创建一个空列表，用来存放状态为启用的，未签订合同的零售商
        List<Retailer> retailerList1 = new ArrayList<>();
        for (Retailer retailer:retailerList){
            //遍历所有状态为启用的零售商，用每一个零售商的id去查合同表，若没有查到则添加到retailerList1中
            List<Contract> contractList = contractService.isExitContract(retailer.getRetailerid());
            if (contractList.size()==0){
                retailerList1.add(retailer);
            }
        }
        //返回启用的，未签订合同的零售商的列表
        return retailerList1;
    }

    /**
     * 在编辑合同页面，点击添加，发送ajax请求获取所有水果的信息
     * @param json
     * @return
     */
    @RequestMapping("/getAllCommodities")
    @ResponseBody
    public List<Commodities> getAllCommodities(@RequestBody String json){
        String name = JSONObject.parseObject(json).getString("name");
        Map<String,Object> map = new HashMap<>();
        if (name != null && name != ""){
            map.put("name",name);
        }
        List<Commodities> commoditiesList = contractService.getAllCommodities(map);
        return commoditiesList;
    }

    /**
     * 在编辑合同页面，在水果列表界面，选中水果后点击确定后发送ajax请求，根据选中的水果的Arrays获取选中的水果，以及附属品的信息，可以填入水果的数量
     * @param arrays
     * @return
     */
    @RequestMapping("/getCommoditiesAndAccessory")
    @ResponseBody
    public List<CommodityVO> getCommoditiesAndAccessory(String[] arrays){

        //创建一个空的CommodityVO对象列表
        List<CommodityVO> commodityVOList = new ArrayList<>();
        for (int i=0;i<arrays.length;i++){
            /*每遍历一个水果id，创建一个空的CommodityVO对象，实例化所需要的属性，最后将这些实例化的对象装到
            List<CommodityVO>列表中*/
            Map<String,Object> map = new HashMap<>();
            CommodityVO commodityVO = new CommodityVO();
            Integer fruitid = Integer.parseInt(arrays[i]);

            //根据水果id获取该水果的相关信息
            map.put("fruitid",fruitid);
            List<Commodities> commoditiesList = contractService.getAllCommodities(map);
            //已知该列表中只有一个Commodities对象，将该对象放入commodityVO对象中
            Commodities commodities = commoditiesList.get(0);
            commodityVO.setCommodities(commodities);

            //根据水果id查找出与其相关的附属品信息，之后将accessoryList放入commodityVO对象中
            List<Accessory> accessoryList = contractService.getAllAccessory(fruitid);
            commodityVO.setAccessoryList(accessoryList);
            //将实例化后的对象装进List<CommodityVO>中
            commodityVOList.add(commodityVO);


        }
        return commodityVOList;
    }

    /**
     * 添加合同
     * @param contract
     * @param page
     * @param size
     * @param model
     * @param type1
     * @param commoditiesIdArrays
     * @param numberArrays
     * @return
     */
    @RequestMapping("/addOneContract")
    public String addOneContract(Contract contract,int page,int size,Model model,String type1,
                                 String[] commoditiesIdArrays,String[] numberArrays){

        contractService.addOneContract(contract,type1,commoditiesIdArrays,numberArrays);
//        return findAllContract(page,size,model,new ContractVo(),null,null,null);
        model.addAttribute("resultMessage", "添加成功！合同编号为" + contract.getBarcode());
        //回显编码框中的值
        model.addAttribute("barcode",contract.getBarcode());
        model.addAttribute("type1",type1);
        return "contract/addContract";
    }

    /**
     * 编辑合同
     * @param contract
     * @param model
     * @param type1
     * @param commoditiesIdArrays
     * @param numberArrays
     * @return
     */
    @RequestMapping("/editContract")
    public String editContract(Contract contract,Model model,String type1,
                               String[] commoditiesIdArrays,String[] numberArrays){
        System.out.println(contract);
        contractService.editContract(contract,type1,commoditiesIdArrays,numberArrays);
        model.addAttribute("resultMessage", "修改成功！");
        return updateContract(contract.getContractid(),model);
    }
}
