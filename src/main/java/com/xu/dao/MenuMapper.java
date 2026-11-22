package com.xu.dao;

import com.xu.pojo.Category;
import com.xu.pojo.Menu;
import com.xu.pojo.WXmap;

import java.util.List;

public interface MenuMapper {
    List<Menu> getMenuList();

    Menu getDishById(int dishesId);

    Menu getDishByName(String dishesName);

    List<Menu> getDishBySuffixName(String dishesName);

    int addDish(Menu dish);

    int updateDish(Menu dish);

    int deleteDish(int dishesId);

    List<Menu> clientGetDishByCategoryId(int categoryId);

    List<Category> getCategory();

    int addCategory(Category category);

    int updateDel(int dishesId);

    List<WXmap> selectMap();

    WXmap selectMapById(int dishesId);

    int updateMap(WXmap wXmap);

    int insertMap(WXmap wXmap);

    void truncateTable();
}
