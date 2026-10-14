<%--
  Created by IntelliJ IDEA.
  User: siddh
  Date: 12-10-2026
  Time: 19:36
  To change this template use File | Settings | File Templates.
--%>
<%@page language="java" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SplitWise | Dashboard</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: Arial, sans-serif;
        background: #f5f7fb;
        color: #1e293b;
    }

    .navbar {
        background: #ffffff;
        padding: 18px 6%;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 1px solid #e5e7eb;
    }

    .brand {
        font-size: 24px;
        font-weight: bold;
        color: #2563eb;
    }

    .user {
        color: #475569;
        font-size: 14px;
    }

    .container {
        max-width: 1150px;
        margin: 35px auto;
        padding: 0 22px;
    }

    .welcome {
        margin-bottom: 28px;
    }

    .welcome h1 {
        font-size: 30px;
        margin-bottom: 9px;
    }

    .welcome p {
        color: #64748b;
        line-height: 1.6;
    }

    .stats {
        display: grid;
        grid-template-columns: repeat(3, minmax(0, 1fr));
        gap: 20px;
        margin-bottom: 35px;
    }

    .card {
        background: white;
        padding: 24px;
        border-radius: 12px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 3px 10px rgba(15, 23, 42, 0.03);
    }

    .card .label {
        color: #64748b;
        font-size: 14px;
        margin-bottom: 14px;
    }

    .card .value {
        font-size: 28px;
        font-weight: bold;
        margin-bottom: 8px;
    }

    .card .description {
        color: #64748b;
        font-size: 13px;
    }

    .section-title {
        font-size: 21px;
        margin-bottom: 18px;
    }

    .actions {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 20px;
    }

    .action-card h3 {
        margin-bottom: 10px;
        font-size: 18px;
    }

    .action-card p {
        color: #64748b;
        font-size: 14px;
        line-height: 1.6;
        margin-bottom: 20px;
    }

    .button {
        display: inline-block;
        padding: 11px 16px;
        border-radius: 7px;
        background: #2563eb;
        color: white;
        text-decoration: none;
        font-size: 14px;
        font-weight: bold;
    }

    .button:hover {
        background: #1d4ed8;
    }

    .secondary {
        background: #eff6ff;
        color: #2563eb;
    }

    .secondary:hover {
        background: #dbeafe;
    }

    .footer {
        text-align: center;
        color: #94a3b8;
        font-size: 13px;
        padding: 35px 15px;
    }

    @media (max-width: 700px) {
        .stats,
        .actions {
            grid-template-columns: 1fr;
        }

        .welcome h1 {
            font-size: 25px;
        }

        .navbar {
            padding: 16px 5%;
        }
    }
</style>

</head>

<body>

<header class="navbar">
    <div class="brand">SplitWise</div>
    <div class="user">
        Welcome, ${displayName}
    </div>
</header>

<main class="container">

<section class="welcome">
    <h1>Your Dashboard</h1>
    <p>
        Track your personal expenses, share bills with friends,
        and keep your group balances organized.
    </p>
</section>

<section class="stats">
    <div class="card">
        <div class="label">Personal Expenses</div>
        <div class="value">${personalExpenseCount}</div>
        <div class="description">
            Number of recorded personal expenses
        </div>
    </div>

    <div class="card">
        <div class="label">Personal Spending</div>
        <div class="value">${totalPersonalSpending}</div>
        <div class="description">
            Total recorded personal spending INR
        </div>
    </div>

    <div class="card">
        <div class="label">My Groups</div>
        <div class="value">${groupCount}</div>
        <div class="description">
            Groups you belong to
        </div>
    </div>
</section>

<section>
    <h2 class="section-title">Quick Actions</h2>

    <div class="actions">

        <div class="card action-card">
            <h3>Personal Expenses</h3>
            <p>
                Record everyday spending such as food,
                transport, shopping, and other purchases.
            </p>
            <a class="button"
               href="${pageContext.request.contextPath}/expenses">
                View Expenses
            </a>
        </div>

        <div class="card action-card">
            <h3>Expense Groups</h3>
            <p>
                Organize shared expenses for trips,
                dinners, roommates, and other activities.
            </p>
            <a class="button secondary"
               href="${pageContext.request.contextPath}/groups">
                View Groups
            </a>
        </div>

    </div>
</section>

</main>

<footer class="footer">
    SplitWise — Manage your money together.
</footer>

</body>
</html>