
package org.siddhesh.splitWise.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import org.springframework.format.annotation.DateTimeFormat;

public class PersonalExpense {

    private Long id;
    private Long userId;
    private String title;
    private BigDecimal amount;
    private String category;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate expenseDate;
    private String notes;

    public PersonalExpense() {
    }

    public PersonalExpense(
            Long id,
            Long userId,
            String title,
            BigDecimal amount,
            String category,
            LocalDate expenseDate,
            String notes) {

        this.id = id;
        this.userId = userId;
        this.title = title;
        this.amount = amount;
        this.category = category;
        this.expenseDate = expenseDate;
        this.notes = notes;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public LocalDate getExpenseDate() {
        return expenseDate;
    }

    public void setExpenseDate(LocalDate expenseDate) {
        this.expenseDate = expenseDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
