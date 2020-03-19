package com.ncu.webchat.utils;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;

public class UploadUtil {

    /**
     * Spring MVC文件上传,返回的是经过处理的path+fileName
     */
    public String upload(HttpServletRequest request, String folder, String userid){
        FileUtil fileUtil = new FileUtil();
        String file_url = "";
        //创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        //判断 request 是否有文件上传,即多部分请求
        if(multipartResolver.isMultipart(request)){
            //转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
            //取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while(iter.hasNext()){
                //取得上传文件
                MultipartFile file = multiRequest.getFile(iter.next());
                String prefix = fileUtil.getFilePrefix(file);
                if(file != null){
                    //取得当前上传文件的文件名称
                    String myFileName = file.getOriginalFilename();
                    //如果名称不为"",说明该文件存在，否则说明该文件不存在
                    if(!myFileName.trim().equals("")){
                        System.out.println(myFileName);
                        //重命名上传后的文件名
                        String fileName =  userid + "." + prefix;
                        //定义上传路径
                        String path = "C:\\Users\\iamso\\OneDrive\\OneDrive\\Web开发\\WebChat\\src\\main\\webapp\\static\\profilehead";

                        //String path = request.getServletContext().getRealPath("/") + folder + "/" + userid;
                        System.out.println(path);
                        File localFile = new File(path, fileName);
                        if(!localFile.exists()){
                           localFile.mkdirs();
                        }
                        try {
                            file.transferTo(localFile);
                            String imagepath = "/upload/webchat/"+userid;
//                            file_url = imagepath + "/" + fileName;
                            file_url = fileName;
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        return file_url;
    }
}
