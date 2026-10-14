
package org.siddhesh.splitWise.controller;

import org.siddhesh.splitWise.model.PersonalExpense;
import org.siddhesh.splitWise.service.PersonalExpenseService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;

@Controller
@RequestMapping("/expenses")
public class PersonalExpenseController {

    private final PersonalExpenseService expenseService;

    // Demo user until authentication is implemented
    private static final Long DEMO_USER_ID = 1L;

    public PersonalExpenseController(
            PersonalExpenseService expenseService) {
        this.expenseService = expenseService;
    }

    // Display the form and expense list
    @GetMapping
    public String showExpenses(Model model) {
        model.addAttribute(
                "expenses",
                expenseService.getAllExpenses(DEMO_USER_ID)
        );

        model.addAttribute("expense", new PersonalExpense());

        return "expenses";
    }

    // Handle form submission
    @PostMapping("/add")
    public String addExpense(
            @ModelAttribute("expense") PersonalExpense expense,
            BindingResult bindingResult,
            Model model) {
        if (bindingResult.hasErrors()) {
            bindingResult.getFieldErrors().forEach(error ->
                    System.out.println(
                            "Field: " + error.getField()
                                    + " | Rejected value: " + error.getRejectedValue()
                                    + " | Error: " + error.getDefaultMessage()
                    )
            );
            model.addAttribute(
                    "errorMessage",
                    "Please enter valid expense details."
            );

            return showPageWithForm(model, expense);
        }

        try {
            expenseService.addExpense(expense, DEMO_USER_ID);

            // Redirect after successful submission
            return "redirect:/expenses";

        } catch (IllegalArgumentException exception) {
            model.addAttribute(
                    "errorMessage",
                    exception.getMessage()
            );

            return showPageWithForm(model, expense);
        }
    }

    private String showPageWithForm(
            Model model,
            PersonalExpense expense) {

        List<PersonalExpense> expenses =
                expenseService.getAllExpenses(DEMO_USER_ID);

        model.addAttribute("expenses", expenses);
        model.addAttribute("expense", expense);

        return "expenses";
    }


    // Display the edit form
    @GetMapping("/edit/{id}")
    public String showEditForm(
            @PathVariable("id") Long id,
            Model model,
            RedirectAttributes redirectAttributes) {

        try {
            PersonalExpense expense =
                    expenseService.getExpenseById(id, DEMO_USER_ID);

            model.addAttribute("expense", expense);

            return "edit-expense";

        } catch (NoSuchElementException exception) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage", "Expense not found."
            );

            return "redirect:/expenses";
        }
    }

    // Process the updated expense
    @PostMapping("/update")
    public String updateExpense(
            @ModelAttribute("expense") PersonalExpense expense,
            BindingResult bindingResult,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            model.addAttribute(
                    "errorMessage",
                    "Please enter valid expense details."
            );

            return "edit-expense";
        }

        try {
            expenseService.updateExpense(expense, DEMO_USER_ID);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Expense updated successfully."
            );

            return "redirect:/expenses";

        } catch (IllegalArgumentException exception) {
            model.addAttribute("errorMessage", exception.getMessage());

            return "redirect:/expenses";

        } catch (NoSuchElementException exception) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Expense not found."
            );

            return "redirect:/expenses";
        }
    }

    // Process the deleted expense
    @PostMapping("/delete")
    public String deleteExpense(
            @RequestParam("id") long id,
            RedirectAttributes redirectAttributes) {

        try {
            expenseService.deleteExpense(id, DEMO_USER_ID);

            redirectAttributes.addFlashAttribute(
                    "successMessage",
                    "Expense deleted successfully."
            );

            return "redirect:/expenses";

        } catch (IllegalArgumentException exception) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    exception.getMessage()
            );

        } catch (NoSuchElementException exception) {
            redirectAttributes.addFlashAttribute(
                    "errorMessage",
                    "Expense not found."
            );


        }
        return "redirect:/expenses";
    }
}
