package cn.itcast.controller;

import cn.itcast.domain.Accessory;
import cn.itcast.service.AccessoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("/accessory")
public class AccessoryController {

    @Autowired
    private AccessoryService accessoryService;

    @RequestMapping("/findAccessory")
    public String findAccessory(Model model,Integer fruitid){
        List<Accessory> accessoryList = accessoryService.findAccessory(fruitid);
        for (Accessory accessory:accessoryList){
            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String date = fmt.format(accessory.getCreatetime());
            accessory.setCtime(date);
        }
        model.addAttribute("accessoryList",accessoryList);
        return "accessory/accessory";
    }
}
