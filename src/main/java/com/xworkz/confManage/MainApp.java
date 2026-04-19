package com.xworkz.confManage;

import org.apache.catalina.startup.Tomcat;

public class MainApp {
    public static void main(String[] args) throws Exception {

        String port = System.getenv("PORT");
        if (port == null) {
            port = "8080";
        }

        Tomcat tomcat = new Tomcat();
        tomcat.setPort(Integer.parseInt(port));

        tomcat.addWebapp("", new java.io.File("src/main/webapp").getAbsolutePath());

        tomcat.start();
        tomcat.getServer().await();
    }
}