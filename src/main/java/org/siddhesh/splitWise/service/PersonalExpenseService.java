
package org.siddhesh.splitWise.service;

import org.siddhesh.splitWise.dao.PersonalExpenseDAO;
import org.siddhesh.splitWise.model.PersonalExpense;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.NoSuchElementException;

@Service
public class PersonalExpenseService {

    private final PersonalExpenseDAO personalExpenseDAO;

    // Constructor-based dependency injection
    public PersonalExpenseService(PersonalExpenseDAO personalExpenseDAO) {
        this.personalExpenseDAO = personalExpenseDAO;
    }

    // CREATE
    public Long addExpense(PersonalExpense expense, Long userId) {

        validateExpense(expense);

        // Set the owner on the server side
        expense.setUserId(userId);

        return personalExpenseDAO.save(expense);
    }

    // READ ALL
    public List<PersonalExpense> getAllExpenses(Long userId) {

        if (userId == null || userId <= 0) {
            throw new IllegalArgumentException("Invalid user ID");
        }

        return personalExpenseDAO.findAllByUserId(userId);
    }

    // READ ONE
    public PersonalExpense getExpenseById(Long id, Long userId) {

        if (id == null || id <= 0 ||
                userId == null || userId <= 0) {
            throw new IllegalArgumentException("Invalid ID");
        }

        PersonalExpense expense = personalExpenseDAO.findById(id)
                .orElseThrow(() ->
                        new NoSuchElementException("Expense not found"));

        // Ensure the expense belongs to the requested user
        if (!userId.equals(expense.getUserId())) {
            throw new NoSuchElementException("Expense not found");
        }

        return expense;
    }

    // UPDATE
    public void updateExpense(PersonalExpense expense, Long userId) {

        validateExpense(expense);

        if (expense.getId() == null || expense.getId() <= 0) {
            throw new IllegalArgumentException("Invalid expense ID");
        }

        // Verify ownership before updating
        getExpenseById(expense.getId(), userId);

        expense.setUserId(userId);

        int rowsUpdated = personalExpenseDAO.update(expense);

        if (rowsUpdated == 0) {
            throw new NoSuchElementException("Expense not found");
        }
    }

    // DELETE
    public void deleteExpense(Long id, Long userId) {

        // Verify ownership before deletion
        getExpenseById(id, userId);

        int rowsDeleted = personalExpenseDAO.delete(id, userId);

        if (rowsDeleted == 0) {
            throw new NoSuchElementException("Expense not found");
        }
    }


    //count expenses by userId
    public long countExpenses(Long userId) {
        return personalExpenseDAO.countByUserId(userId);
    }

    //total spending in expenses by userId
    public long totalSpending(Long userId) {
        return personalExpenseDAO.totalSpendingByUserId(userId);
    }

    // Common validation
    private void validateExpense(PersonalExpense expense) {

        if (expense == null) {
            throw new IllegalArgumentException("Expense is required");
        }

        if (expense.getTitle() == null ||
                expense.getTitle().isBlank()) {
            throw new IllegalArgumentException(
                    "Expense title is required");
        }

        if (expense.getTitle().length() > 120) {
            throw new IllegalArgumentException(
                    "Title cannot exceed 120 characters");
        }

        if (expense.getAmount() == null ||
                expense.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException(
                    "Amount must be greater than zero");
        }

        if (expense.getCategory() == null ||
                expense.getCategory().isBlank()) {
            throw new IllegalArgumentException(
                    "Category is required");
        }

        if (expense.getCategory().length() > 50) {
            throw new IllegalArgumentException(
                    "Category cannot exceed 50 characters");
        }

        if (expense.getExpenseDate() == null) {
            throw new IllegalArgumentException(
                    "Expense date is required");
        }
    }
}
