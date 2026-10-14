package org.siddhesh.splitWise.controller;

import org.siddhesh.splitWise.service.PersonalExpenseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DashboardController {
    private final PersonalExpenseService expenseService;

    // Demo user until authentication is implemented
    private static final Long DEMO_USER_ID = 1L;

    public DashboardController(
            PersonalExpenseService expenseService) {
        this.expenseService = expenseService;
    }

    @RequestMapping ({ "/dashboard"})
    public String showDashboard(Model model) {

        model.addAttribute("displayName", "Demo User 1");
        model.addAttribute("personalExpenseCount", expenseService.countExpenses(DEMO_USER_ID));
        model.addAttribute("totalPersonalSpending", expenseService.totalSpending(DEMO_USER_ID));
        model.addAttribute("groupCount", 0);

        return "dashboard";
    }
}

