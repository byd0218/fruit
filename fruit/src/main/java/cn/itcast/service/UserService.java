package cn.itcast.service;

import cn.itcast.domain.User;

import java.util.List;

public interface UserService {
   //查找所有用户
   List<User> testSpring();
   //验证登录
   User testLogin(String username,String password);
   //注册用户
   void register(User user);
   //按条件查找用户
   List<User> findUserByCondition(User user);
   //修改密码
   void updatePassword(User user);
   //查找出数据库中与注册名相同的用户
   List<User> getSameUsername(String username);

}
