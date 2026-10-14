package org.siddhesh.splitWise.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class DbTestDAO {

    private final JdbcTemplate jdbcTemplate;

    public DbTestDAO(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public Integer testConnection() {
        return jdbcTemplate.queryForObject(
                "SELECT 1",
                Integer.class
        );
    }

    public Integer getExpenseCount() {
        return jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM personal_expenses",
                Integer.class
        );
    }
}