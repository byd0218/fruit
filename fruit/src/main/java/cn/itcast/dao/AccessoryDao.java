package cn.itcast.dao;

import cn.itcast.domain.Accessory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AccessoryDao {

    List<Accessory> findAccessory(Integer fruitid);
}

