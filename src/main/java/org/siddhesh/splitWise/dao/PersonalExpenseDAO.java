
package org.siddhesh.splitWise.dao;

import org.siddhesh.splitWise.model.PersonalExpense;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public class PersonalExpenseDAO {

    private final JdbcTemplate jdbcTemplate;

    public PersonalExpenseDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    // Converts one database row into a Java object
    private final RowMapper<PersonalExpense> rowMapper =
            (rs, rowNum) -> {
                PersonalExpense expense = new PersonalExpense();

                expense.setId(rs.getLong("id"));
                expense.setUserId(rs.getLong("user_id"));
                expense.setTitle(rs.getString("title"));
                expense.setAmount(rs.getBigDecimal("amount"));
                expense.setCategory(rs.getString("category"));
                expense.setExpenseDate(
                        rs.getDate("expense_date").toLocalDate()
                );
                expense.setNotes(rs.getString("notes"));

                return expense;
            };

    // CREATE: Insert an expense and return its generated ID
    public Long save(PersonalExpense expense) {

        String sql = "INSERT INTO personal_expenses(user_id, title, amount, category, expense_date, notes)VALUES (?, ?, ?, ?, ?, ?) RETURNING id ";

        return jdbcTemplate.queryForObject(
                sql,
                Long.class,
                expense.getUserId(),
                expense.getTitle(),
                expense.getAmount(),
                expense.getCategory(),
                expense.getExpenseDate(),
                expense.getNotes()
        );
    }

    // READ: Retrieve all expenses belonging to one user
    public List<PersonalExpense> findAllByUserId(Long userId) {

        String sql = "SELECT id, user_id, title, amount,category, expense_date, notes FROM personal_expenses WHERE user_id = ? ORDER BY expense_date DESC, id DESC";

        return jdbcTemplate.query(sql, rowMapper, userId);
    }

    // READ: Retrieve one expense by ID
    public Optional<PersonalExpense> findById(Long id) {

        String sql = " SELECT id, user_id, title, amount, category, expense_date, notes FROM personal_expenses WHERE id = ?";

        List<PersonalExpense> results =
                jdbcTemplate.query(sql, rowMapper, id);

        return results.stream().findFirst();
    }

    // UPDATE: Modify an existing expense
    public int update(PersonalExpense expense) {

        String sql = " UPDATE personal_expenses SET title = ?, amount = ?, category = ?, expense_date = ?, notes = ? WHERE id = ? AND user_id = ? ";

        return jdbcTemplate.update(
                sql,
                expense.getTitle(),
                expense.getAmount(),
                expense.getCategory(),
                expense.getExpenseDate(),
                expense.getNotes(),
                expense.getId(),
                expense.getUserId()
        );
    }

    // DELETE: Remove an expense belonging to a user
    public int delete(Long id, Long userId) {

        String sql = " DELETE FROM personal_expenses WHERE id = ? AND user_id = ? ";

        return jdbcTemplate.update(sql, id, userId);
    }

    //count expenses
    public long countByUserId(Long userId){
        String sql="select count(*) from personal_expenses where user_id = ?";
        return jdbcTemplate.queryForObject(sql,Long.class,userId);
    }

    //total spending from expenses
    public long totalSpendingByUserId(Long userId){
        String sql="select sum(amount) from personal_expenses where user_id = ?";
        return jdbcTemplate.queryForObject(sql,Long.class,userId);
    }
}
