package com.xu.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.google.gson.Gson;
import com.xu.config.MenuSelector;
import com.xu.pojo.*;
import com.xu.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

@Controller
public class MenuController {
    private MenuService menuService;

    @Autowired
    public void setMenuService(MenuService menuService) {
        this.menuService = menuService;
    }

    @RequestMapping("/allDishes")
    public String allDishes(Model model, HttpSession session) {
        List<Menu> menuList = menuService.getMenuList();
        List<Category> categoryList = menuService.getCategory();
        session.setAttribute("categoryList", categoryList);
        model.addAttribute("list", menuList);
        return "allDishes";
    }

    @RequestMapping("/toAddDish")
    public String toAddDish() {
        return "addDish";
    }

    @RequestMapping("/addDish")
    public String addDish(Menu dish, Model model, MultipartFile multipartFile) {
        System.out.println("原始文件名：" + multipartFile);

        String fileName = UUID.randomUUID().toString();
        String subfix = multipartFile.getOriginalFilename();
        if (subfix != null) {
            subfix = subfix.substring(subfix.lastIndexOf("."));
        }
        fileName = fileName + subfix;
        System.out.println("UUID文件名：" + fileName);

        String path = "D:\\MavenProject\\软件工程三版\\test\\src\\main\\webapp\\upload";
        System.out.println("存储路径：" + path);

        try {
            multipartFile.transferTo(new File(path + "\\" + fileName));
            dish.setImage("upload/" + fileName);
        } catch (Exception e) {
            dish.setImage(null);
            e.printStackTrace();
        }
        int res = menuService.addDish(dish);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
//        System.out.println(dish);
        return "redirect:/allDishes";
    }

    @RequestMapping("/toUpdateDish")
    public String toUpdateDish(int dishesId, Model model) {
        Menu dish = menuService.getDishById(dishesId);
        model.addAttribute("DISH", dish);
        return "updateDish";
    }

    @RequestMapping("/updateDish")
    public String updateDish(Menu dish, Model model, MultipartFile multipartFile) {
        System.out.println("原始文件名：" + multipartFile);

        String fileName = UUID.randomUUID().toString();
        String subfix = multipartFile.getOriginalFilename();
        if (subfix != null) {
            subfix = subfix.substring(subfix.lastIndexOf("."));
        }
        fileName = fileName + subfix;
        System.out.println("UUID文件名：" + fileName);

        String path = "D:\\MavenProject\\软件工程三版\\test\\src\\main\\webapp\\upload";
        System.out.println("存储路径：" + path);

        try {
            multipartFile.transferTo(new File(path + "\\" + fileName));
            dish.setImage("upload/" + fileName);
        } catch (Exception e) {
            dish.setImage(null);
            e.printStackTrace();
        }
        int res = menuService.updateDish(dish);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
        return "redirect:/allDishes";
    }


    @RequestMapping("/deleteDish")
    public String deleteDish(int dishesId, Model model) {
        System.out.println(dishesId);
//        int res = menuService.deleteDish(dishesId);
        int res = menuService.updateDel(dishesId);
        if (res >= 1)
            model.addAttribute("state", "Success!");
        else
            model.addAttribute("state", "Fail!");
        return "redirect:/allDishes";
    }

    @RequestMapping("/getDishBySuffixName")
    public String getDishBySuffixName(String dishesName, Model model) {
        List<Menu> dishesList = menuService.getDishBySuffixName(dishesName);
        //System.out.println(dishesList);
        model.addAttribute("list", dishesList);
        return "allDishes";
    }

    @RequestMapping("/clientHome")
    public String clientHome(){
        return "clientHome";
    }

    @RequestMapping("home")
    public String home(){
        return "home";
    }

    @RequestMapping("clientOrder")
    public String clientOrder(Model model, int pageNum, HttpSession session) {
//        int pageNum = 3;
        String orderBy = "dishesId asc";
        PageHelper.startPage(pageNum, 6, orderBy);
        List<Menu> menuList = menuService.getMenuList();
        List<Category> categoryList = menuService.getCategory();
//        model.addAttribute("list",menuList);
        PageInfo<Menu> pageInfo = new PageInfo<Menu>(menuList);
//        System.out.println(pageInfo);
        model.addAttribute("pageInfo", pageInfo);
        session.setAttribute("category", categoryList);
        return "clientOrder";
    }

    @RequestMapping("clientOrderPopular")
    public String clientOrderPopular(Model model) {
        List<Menu> menuPopularList = menuService.getMenuList();
        List<Menu> menuList = MenuSelector.selectRandomMenus(menuPopularList, 5);
        model.addAttribute("list", menuList);
        return "clientOrderPopular";
    }

    @RequestMapping("clientGetDishBySuffixName")
    public String clientGetDishBySuffixName(String dishesName, Model model) {
        int pageNum = 1;
        PageHelper.startPage(pageNum, 6);
        List<Menu> dishesList = menuService.getDishBySuffixName(dishesName);
        PageInfo<Menu> pageInfo = new PageInfo<Menu>(dishesList);
        model.addAttribute("pageInfo", pageInfo);
        return "clientOrder";
    }


    @RequestMapping("clientAddDish")
    public String clientAddDish(HttpSession session, int dishesId) {
        HashMap<Integer, Integer> map = (HashMap<Integer, Integer>) session.getAttribute("cart");
        if (map.containsKey(dishesId))
            map.put(dishesId, map.get(dishesId) + 1);
        else
            map.put(dishesId, 1);
        return "redirect:/clientOrder?pageNum=1";
    }

    @RequestMapping("clientCart")
    public String clientCart(Model model, HttpSession session) {
        double totalPrice = 0;
        HashMap<Integer, Integer> cartMap = (HashMap<Integer, Integer>) session.getAttribute("cart");
        ArrayList<Order> list = new ArrayList<Order>();
        for (Map.Entry<Integer, Integer> entry : cartMap.entrySet()) {
            Order order = new Order();
            Menu dish = menuService.getDishById(entry.getKey());
            order.setDishesNum(entry.getValue());
            order.setMenu(dish);
            list.add(order);
            totalPrice += dish.getUnitPrice() * order.getDishesNum();
        }
        session.setAttribute("cartList", list);
        session.setAttribute("totalPrice", totalPrice);
        return "redirect:/clientCouponsEffective";
    }


    @RequestMapping("clientCartDelete")
    public String clientCartDelete(HttpSession session, int dishesId) {
        HashMap<Integer, Integer> cartMap = (HashMap<Integer, Integer>) session.getAttribute("cart");
        if (cartMap.get(dishesId) > 1)
            cartMap.put(dishesId, cartMap.get(dishesId) - 1);
        else
            cartMap.remove(dishesId);
        return "redirect:/clientCart";
    }

    @ResponseBody
    @RequestMapping("validationDishesName")
    public String validationName(String Name) {

        Menu dish = menuService.getDishByName(Name);//不存在则返回null
        if (dish == null)
            return "";
        return "该菜名已存在";
    }

    @RequestMapping("clientGetDishByCategoryId")
    public String clientGetDishByCategoryId(int categoryId, Model model) {
        List<Menu> menuList = menuService.clientGetDishByCategoryId(categoryId);
        model.addAttribute("categoryList", menuList);
        return "clientCategory";
    }

    @RequestMapping("addCategory")
    public String addCategory(String categoryName, HttpSession session) {
        Category category = new Category(null, categoryName);
        int res = menuService.addCategory(category);
        List<Category> categoryList = menuService.getCategory();
        session.setAttribute("categoryList", categoryList);
        return "redirect:/allDishes";
    }

    @RequestMapping("/clientTest")
    public String clientTest() {
        return "clientTest";
    }


    @ResponseBody
    @RequestMapping("/wxMenu")
    public String wxMenu() {
        List<Menu> menuList = menuService.getMenuList();
        Gson gson = new Gson();
        return gson.toJson(menuList);
    }

    @ResponseBody
    @RequestMapping("/wxMenuInfo")
    public String wxMenuInfo(String dishesName) {
        Menu menu = menuService.getDishByName(dishesName);
        Gson gson = new Gson();
        return gson.toJson(menu);
    }

    @ResponseBody
    @RequestMapping("/wxAddDishes")
    public String wxAddDishes(int dishesId, HttpSession session) {
//        1 通过ID查找map里面是否有数据
        WXmap wXmap = menuService.selectMapById(dishesId);
        if (wXmap != null) {
            wXmap.setNum(wXmap.getNum() + 1);
            int res = menuService.updateMap(wXmap);
        } else {
            WXmap wXmap1 = new WXmap();
            wXmap1.setId(dishesId);
            wXmap1.setNum(1);
            int res = menuService.insertMap(wXmap1);
        }
//        2 有的话num+1
//        3 没有插入dishesId 数量为1
        return "1";
    }

    @ResponseBody
    @RequestMapping("wxCart")
    public String wxCart() {
        ArrayList<Order> list = new ArrayList<Order>();
        List<WXmap> wXmaps = menuService.selectMap();
        for (WXmap wXmap : wXmaps) {
            Order order = new Order();
            Menu menu = menuService.getDishById(wXmap.getId());
            order.setMenu(menu);
            order.setDishesNum(wXmap.getNum());
            list.add(order);
        }
        Gson gson = new Gson();
        return gson.toJson(list);
    }
}
