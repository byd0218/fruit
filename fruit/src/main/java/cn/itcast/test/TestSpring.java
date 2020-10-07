package cn.itcast.test;

import cn.itcast.dao.CommoditiesDao;
import cn.itcast.domain.User;
import cn.itcast.service.CommoditiesService;
import cn.itcast.service.UserService;
import cn.itcast.service.impl.CommoditiesServiceImpl;
import cn.itcast.vo.CommodityVO;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;

import java.util.List;

public class TestSpring {

    @Test
    public void run1(){
        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext" +
                ".xml");
        //获取对象
        UserService as = (UserService) ac.getBean("userService");
        //调用方法
        as.testSpring();
    }

    @Test
    public void test1() {
        ApplicationContext ac = new ClassPathXmlApplicationContext("classpath:applicationContext" +
                ".xml");

        CommoditiesService commoditiesService = (CommoditiesService)ac.getBean("commoditiesService");

        List<CommodityVO> vOsByContractId = commoditiesService.getVOsByContractId(1);

        System.out.println(vOsByContractId.toString());
    }
}
