package com.xu.config;

import com.xu.pojo.Menu;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class MenuSelector {
    /**
     * 从给定的菜单列表中随机选择指定数量的不重复菜单项。
     *
     * @param menus 原始菜单列表
     * @param count 需要选择的菜单项数量
     * @return 包含随机选中的菜单项的列表
     */
    public static List<Menu> selectRandomMenus(List<Menu> menus, int count) {
        // 创建一个新的列表来存储选中的菜单项
        List<Menu> selectedMenus = new ArrayList<>();

        // 创建一个随机数生成器
        Random random = new Random();

        // 循环直到选中足够的菜单项
        while (selectedMenus.size() < count) {
            // 随机选择一个索引
            int index = random.nextInt(menus.size());

            // 获取该索引对应的菜单项
            Menu menu = menus.get(index);

            // 如果选中的菜单项不在已选中的列表中，则添加到选中列表中
            if (!selectedMenus.contains(menu)) {
                selectedMenus.add(menu);
            }
        }

        return selectedMenus;
    }
}

