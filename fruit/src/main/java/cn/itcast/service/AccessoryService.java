package cn.itcast.service;

import cn.itcast.domain.Accessory;

import java.util.List;

public interface AccessoryService {
    List<Accessory> findAccessory(Integer fruitid);
}
