package com.ncu.webchat.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface MyDownload {

    public void downloadSolve( HttpServletRequest request, HttpServletResponse response,String path) throws IOException;
}
