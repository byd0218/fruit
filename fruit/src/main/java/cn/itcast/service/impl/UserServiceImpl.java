package cn.itcast.service.impl;

import cn.itcast.dao.UserDao;
import cn.itcast.domain.User;
import cn.itcast.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public List<User> testSpring() {
        return userDao.findAll();
    }

    @Override
    public User testLogin(String username,String password) {
        return userDao.testLogin(username,password);
    }

    @Override
    public void register(User user) {
        userDao.register(user);
    }

    @Override
    public List<User> findUserByCondition(User user) {
        return userDao.findUserByCondition(user);
    }

    @Override
    public void updatePassword(User user) {
        userDao.updatePassword(user);
    }

    /**
     * 查找出数据库中与注册名相同的用户
     * @param username
     * @return
     */
    @Override
    public List<User> getSameUsername(String username) {
        return userDao.getSameUsername(username);
    }


}
