package cn.itcast.controller;

import cn.itcast.domain.Commodities;
import cn.itcast.service.CommoditiesService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/commodities")
public class CommoditiesController {

    @Autowired
    private CommoditiesService commoditiesService;

    @RequestMapping("/findCommodities")
    public String findCommodities(@RequestParam(name = "page",required = true,defaultValue = "1")
                                          int page,@RequestParam(name = "size",required =
            true,defaultValue = "4") int size,
                                  Model model,
                                  Commodities commodities,
                                  Double startPrice,Double endPrice,
                                  String startTime, String endTime){

        Map<String, Object> map = new HashMap<>();
        map.put("name", commodities.getName());
        map.put("locality", commodities.getLocality());

        if (startTime != null && !startTime.equals(""))
            map.put("startTime", startTime);
        if (endTime != null && !endTime.equals(""))
            map.put("endTime", endTime);
        if(startPrice != null && startPrice >= 0.0)
            map.put("startPrice", startPrice);
        if(endPrice != null && endPrice >= 0.0)
            map.put("endPrice", endPrice);

        List<Commodities> commoditiesList = commoditiesService.findCommodities(map,page,size);
        for (Commodities commodities1:commoditiesList){
            System.out.println(commodities1);
            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = fmt.format(commodities1.getCreatetime());
            commodities1.setCtime(date);
        }
        model.addAttribute("name",commodities.getName());
        model.addAttribute("locality",commodities.getLocality());
//        model.addAttribute("commoditiesList", commoditiesList.size() < 1 ? null : commoditiesList);
        PageInfo pageInfo = new PageInfo(commoditiesList);
        model.addAttribute("size",size);
        model.addAttribute("page",page);
        model.addAttribute("pageInfo",pageInfo.getList().size() < 1?null:pageInfo);
        System.out.println(pageInfo.getList());

        //输入框中要回显的数据
        model.addAttribute("name",commodities.getName());
        model.addAttribute("locality",commodities.getLocality());
        model.addAttribute("startPrice",startPrice);
        model.addAttribute("endPrice",endPrice);
        model.addAttribute("startTime",startTime);
        model.addAttribute("endTime",endTime);

        return "commodities/commoditiesHome-page";
    }

    /**
     * 添加货物
     * @param page
     * @param size
     * @param model
     * @param commodities
     * @return
     */
    @RequestMapping("/addCommodities")
    public String addCommodities(@RequestParam(name = "page",required = true,defaultValue = "1")
                                             int page,@RequestParam(name = "size",required =
            true,defaultValue = "4") int size,Model model,Commodities commodities){
        commodities.setCreatetime(new Date());
        commoditiesService.addCommodities(commodities);
        return findCommodities(page,size,model,new Commodities(),null,null,null,null);
    }

    /**
     * 删除货物
     * @param page
     * @param size
     * @param model
     * @param fruitid
     * @return
     */
    @RequestMapping("/delCommodities")
    public String delCommodities(@RequestParam(name = "page",required = true,defaultValue = "1")
                                             int page,@RequestParam(name = "size",required =
            true,defaultValue = "4") int size,Model model,Integer fruitid){
        commoditiesService.delCommodities(fruitid);
        return findCommodities(page,size,model,new Commodities(),null,null,null,null);
    }

    /**
     * 更新货物
     * @param page
     * @param size
     * @param model
     * @param commodities
     * @param fid
     * @param pri
     * @return
     */
    @RequestMapping("/updateCommodities")
    public String updateCommodities(@RequestParam(name = "page",required = true,defaultValue = "1")
                                                int page,@RequestParam(name = "size",required =
            true,defaultValue = "4") int size,Model model,Commodities commodities,String fid,String pri){
        commodities.setCreatetime(new Date());
        commoditiesService.updateCommodities(commodities);
        return findCommodities(page,size,model,new Commodities(),null,null,null,null);
    }

    /*@GetMapping("/v1/{contractid}")
    public List<CommodityVO> getCommodityVOByContractId(@PathVariable("contractid") Integer contractId) {

        List<CommodityVO> commodityVOList = commoditiesService.getVOsByContractId(contractId);

        System.out.println(commodityVOList.toString());
        return null;
    }*/
}
