package cn.itcast.controller;

import cn.itcast.domain.Contract;
import cn.itcast.domain.Retailer;
import cn.itcast.service.ContractService;
import cn.itcast.service.RetailerService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/retailer")
public class RetailerController {
    @Autowired
    private RetailerService retailerService;

    @Autowired
    private ContractService contractService;

    @RequestMapping("/findAllRetailer")
    public String findAllRetailer(@RequestParam(name = "page",required = true,defaultValue = "1")
                                              int page, @RequestParam(name = "size",required =
            true,defaultValue = "4") int size, Model model,Retailer retailer,
                                  String status1,String startTime,
                                  String endTime){

        Map<String, Object> map = new HashMap<>();
        map.put("name",retailer.getName());
        map.put("telephone",retailer.getTelephone());
        map.put("address",retailer.getAddress());
        System.out.println(status1);
        if (status1!=null && !status1.equals("") && !status1.equals("-1")){    //符合该条件时不进行拼接
            Integer s = Integer.parseInt(status1);
            retailer.setStatus(s);
            map.put("status",retailer.getStatus());
        }


        if (startTime != null && !startTime.equals(""))
            map.put("startTime", startTime);
        if (endTime != null && !endTime.equals(""))
            map.put("endTime", endTime);
        List<Retailer> retailerList = retailerService.findAllRetailer(map,page,size);
        for (Retailer retailer1:retailerList){
            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = fmt.format(retailer1.getCreatetime());
            retailer1.setCtime(date);
        }
        PageInfo pageInfo = new PageInfo(retailerList);
        model.addAttribute("size",size);
        model.addAttribute("page",page);
        model.addAttribute("pageInfo",pageInfo.getList().size()<1?null:pageInfo);
        //输入框中显示要回显的数据
        model.addAttribute("name",retailer.getName());
        model.addAttribute("telephone",retailer.getTelephone());
        model.addAttribute("address",retailer.getAddress());
        model.addAttribute("status1",status1);
        model.addAttribute("startTime",startTime);
        model.addAttribute("endTime",endTime);

        return "retailer/retailerHome";
    }

    @RequestMapping("/addRetailer")
    public String addRetailer(@RequestParam(name = "page",required = true,defaultValue = "1")
                                          int page, @RequestParam(name = "size",required =
            true,defaultValue = "4") int size, Model model,Retailer retailer){
        retailer.setCreatetime(new Date());
        retailerService.addRetailer(retailer);
        return findAllRetailer(page,size,model,new Retailer(),null,null,null);
    }

    @RequestMapping("/updateRetailer")
    public String updateCommodities(@RequestParam(name = "page",required = true,defaultValue = "1")
                                                int page, @RequestParam(name = "size",required =
            true,defaultValue = "4") int size, Model model,Retailer retailer,String status1){
        if (status1!=null && status1!=""){
            Integer s = Integer.parseInt(status1);
            retailer.setStatus(s);
        }
        retailerService.updateRetailer(retailer);
        return findAllRetailer(page,size,model,new Retailer(),null,null,null);
    }

    /**
     * 删除合同前，判断该零售商是否有合同，如果有的话请先删除合同
     * @param page
     * @param size
     * @param model
     * @param retailerid
     * @return
     */
    @RequestMapping("/delRetailer")
    public String delRetailer(@RequestParam(name = "page",required = true,defaultValue = "1")
                                            int page, @RequestParam(name = "size",required =
            true,defaultValue = "4") int size, Model model,Integer retailerid,String name){
        List<Contract> contractList = contractService.isExitContract(retailerid);
        if (contractList.size()>0){
            model.addAttribute("errorMessage","要删除的零售商 "+ name +" 有合同，需先删除合同！");
        }else {
            retailerService.delRetailer(retailerid);
        }
        return findAllRetailer(page,size,model,new Retailer(),null,null,null);
    }
}
