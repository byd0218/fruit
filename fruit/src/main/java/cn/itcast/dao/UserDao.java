package cn.itcast.dao;

import cn.itcast.domain.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface UserDao {
    List<User> findAll();

    User testLogin(@Param("username") String username, @Param("password") String password);

    void register(User user);

    List<User> findUserByCondition(User user);

    void updatePassword(User user);

    //查找出数据库中与注册名相同的用户
    List<User> getSameUsername(String username);

}
