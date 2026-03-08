package com.xworkz.confManage.controller.delegateDashBoard;

import com.xworkz.confManage.entity.conference.ConferenceEntity;
import com.xworkz.confManage.service.delegatedashboard.DelegateDashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class DelegateDashboardController {
    @Autowired
    private DelegateDashboardService delegateDashboardService;




}
