package cn.itcast.controller;

import cn.itcast.domain.User;
import cn.itcast.service.UserService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {


    @Autowired
    private UserService userService;

    /**
     * 验证登录，去数据库中查找用户名和密码
     * @param
     * @param
     * @return
     */
    @RequestMapping("/testLogin")
    public ModelAndView testLogin(String username, String password, HttpSession session){
        ModelAndView mv = new ModelAndView();
        /*System.out.println(username);
        System.out.println(password);*/
        User user = userService.testLogin(username,password);
        if (user != null){
//            mv.addObject("user",user);
            mv.setViewName("home");
            //将user对象放入session会话中，用的话User.属性，即可
            session.setAttribute("User", user);
            return mv;
        }
        mv.addObject("errorMsg","用户名或密码错误!");
        mv.setViewName("login");
        return mv;
    }

    /**
     * 跳转注册页面
     * @param
     * @param
     * @return
     */
    @RequestMapping("/testRegister")
    public String testRegister(){
        return "register";
    }

    /**
     * 用户注册
     * @param model
     * @param user
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    @RequestMapping("/register")
    public String register(Model model,User user, HttpServletRequest request,
                         HttpServletResponse response) throws IOException {
        //查找出数据库中与注册名相同的用户
        List<User> userList = userService.getSameUsername(user.getUsername());
        if (userList.size() > 0){
            model.addAttribute("messageError","注册失败，用户名已占用");
            return "register";
        }
        userService.register(user);
        model.addAttribute("messageSuccess","注册成功，请返回登录");
        return "register";
    }

    /**
     * 注册完后返回登录页面
     * @return
     */
    @RequestMapping("/returnLogin")
    public String returnLogin(){
        return "login";
    }

    @RequestMapping("/Logout")
    public String Logout(HttpSession session){
        session.removeAttribute("User");
        return "login";
    }

    @RequestMapping("/commoditiesHome")
    public String commoditiesHome(){
        return "commodities/commoditiesHome";
    }

    @RequestMapping("/retailerHome")
    public String retailerHome(){
        return "retailer/retailerHome";
    }

    @RequestMapping("/contractHome")
    public String contractHome(){
        return "contract/contractHome";
    }

    /**
     * 将所有用户，和登录用户的姓名，密码传到用户设置页面
     * @param model
     * @param name
     * @param password
     * @param userid
     * @return
     */
    @RequestMapping("/test")
    public String test(Model model,String name,String password,Integer userid){
        //查询到了所有的用户
        List<User> userList = userService.testSpring();
        model.addAttribute("userList",userList);
        model.addAttribute("name",name);
        /*System.out.println(name);
        System.out.println(password);*/
        model.addAttribute("password",password);
        model.addAttribute("userid",userid);

        return "test/test";
    }

    /**
     * 按条件查找用户
     * @param user
     * @param model
     * @return
     */
    @RequestMapping("/findUserByCondition")
    public String findUserByCondition(User user, Model model){
        System.out.println(user);
        List<User> userList = userService.findUserByCondition(user);
        System.out.println(userList);
        model.addAttribute("userList",userList);
        return "test/test";
    }

    /**
     * 根据用户id修改密码
     * @param password
     * @param userid
     * @param response
     * @throws IOException
     */
    @RequestMapping("/updatePassword")
    public String updatePassword(String password,Integer userid,
                        HttpServletResponse response,Model model) throws IOException {
        User user = new User();
        //要修改的密码
        user.setPassword(password);
        user.setUserid(userid);
//        System.out.println(password);
//        System.out.println(userid);
        userService.updatePassword(user);
        response.setContentType("text/html;charset=UTF-8");


        model.addAttribute("MessageSuccess","修改成功");
        return "login";
    }
}
