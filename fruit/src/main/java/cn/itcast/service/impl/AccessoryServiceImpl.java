package cn.itcast.service.impl;

import cn.itcast.dao.AccessoryDao;
import cn.itcast.domain.Accessory;
import cn.itcast.service.AccessoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("accessoryService")
public class AccessoryServiceImpl implements AccessoryService {

    @Autowired
    private AccessoryDao accessoryDao;

    @Override
    public List<Accessory> findAccessory(Integer fruitid) {
        return accessoryDao.findAccessory(fruitid);
    }
}
