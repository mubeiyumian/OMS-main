package com.xu.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.UUID;

@Controller
public class ImageController {
    @RequestMapping("/clientImage")
    public String clientImage() {
        return "clientImage";
    }

    @RequestMapping("clientUpload")
    public String clientUpload(MultipartFile multipartFile, HttpServletRequest httpServletRequest, HttpSession session) {
        System.out.println("原始文件名：" + multipartFile);

        String fileName = UUID.randomUUID().toString();
        String subfix = multipartFile.getOriginalFilename();
        if (subfix != null) {
            subfix = subfix.substring(subfix.lastIndexOf("."));
        }
        fileName = fileName + subfix;
        System.out.println("UUID文件名：" + fileName);

        String path = "C:\\Download_Edge\\test\\src\\main\\webapp\\upload";
        System.out.println("存储路径：" + path);

        try {
            multipartFile.transferTo(new File(path + "\\" + fileName));
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.setAttribute("filePath", "upload/" + fileName);
        return "clientShow";
    }
}
