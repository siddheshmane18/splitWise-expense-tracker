<%--
  Created by IntelliJ IDEA.
  User: siddh
  Date: 12-10-2026
  Time: 20:25
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>SplitWise | Personal Expenses</title>

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
            background: white;
            padding: 18px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #e5e7eb;
        }

        .brand {
            font-size: 23px;
            font-weight: bold;
            color: #2563eb;
            text-decoration: none;
        }

        .nav-link {
            color: #475569;
            text-decoration: none;
            font-size: 14px;
        }

        .container {
            max-width: 1150px;
            margin: 35px auto;
            padding: 0 22px;
        }

        .page-heading {
            margin-bottom: 25px;
        }

        .page-heading h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .muted {
            color: #64748b;
            font-size: 14px;
            line-height: 1.6;
        }

        .layout {
            display: grid;
            grid-template-columns: 340px minmax(0, 1fr);
            gap: 22px;
            align-items: start;
        }

        .card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            border: 1px solid #e5e7eb;
            box-shadow: 0 3px 10px rgba(15, 23, 42, 0.03);
        }

        .card h2 {
            font-size: 19px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 16px;
        }

        label {
            display: block;
            font-size: 13px;
            font-weight: bold;
            margin-bottom: 7px;
        }

        input, select, textarea {
            width: 100%;
            padding: 11px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font-size: 14px;
            font-family: inherit;
            background: white;
        }

        input:focus, select:focus, textarea:focus {
            outline: 2px solid #bfdbfe;
            border-color: #2563eb;
        }

        textarea {
            resize: vertical;
            min-height: 75px;
        }

        .button {
            width: 100%;
            display: inline-block;
            border: none;
            border-radius: 7px;
            background: #2563eb;
            color: white;
            padding: 12px 16px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
        }

        .button:hover {
            background: #1d4ed8;
        }

        .alert {
            margin-bottom: 18px;
            padding: 12px 14px;
            border-radius: 7px;
            background: #fef2f2;
            color: #b91c1c;
            font-size: 14px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }

        th, td {
            padding: 13px 10px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }

        th {
            color: #64748b;
            font-size: 12px;
            text-transform: uppercase;
            white-space: nowrap;
        }

        td {
            overflow-wrap: anywhere;
        }

        .delete-button {
            background: #dc2626;
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px 12px;
            cursor: pointer;
        }

        .delete-button:hover {
            background: #b91c1c;
        }

        .amount {
            font-weight: bold;
            white-space: nowrap;
        }

        .category {
            display: inline-block;
            background: #eff6ff;
            color: #1d4ed8;
            padding: 5px 9px;
            border-radius: 20px;
            font-size: 12px;
        }

        .empty-state {
            padding: 35px 10px;
            text-align: center;
        }

        .empty-state h3 {
            margin-bottom: 8px;
            font-size: 17px;
        }

        .footer {
            text-align: center;
            padding: 30px 15px;
            color: #94a3b8;
            font-size: 13px;
        }

        @media (max-width: 850px) {
            .layout {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 500px) {
            .navbar {
                padding: 16px 5%;
            }

            .container {
                padding: 0 14px;
                margin-top: 25px;
            }

            .card {
                padding: 17px;
            }
        }
    </style>
</head>

<body>

<header class="navbar">
    <a class="brand"
       href="${pageContext.request.contextPath}/dashboard">
        SplitWise
    </a>

    <a class="nav-link"
       href="${pageContext.request.contextPath}/dashboard">
        ← Back to Dashboard
    </a>
</header>

<main class="container">

    <section class="page-heading">
        <h1>Personal Expenses</h1>
        <p class="muted">
            Record your daily spending and keep track of your expenses.
        </p>
    </section>

    <c:if test="${not empty errorMessage}">
        <div class="alert" role="alert">
            <c:out value="${errorMessage}"/>
        </div>
    </c:if>
    <c:if test="${not empty successMessage}">
        <div class="success" role="status">
            <c:out value="${successMessage}"/>
        </div>
    </c:if>

    <section class="layout">

        <!-- Add Expense Form -->
        <div class="card">
            <h2>Add an Expense</h2>

            <form action="${pageContext.request.contextPath}/expenses/add"
                  method="post">

                <div class="form-group">
                    <label for="title">Expense title</label>
                    <input type="text"
                           id="title"
                           name="title"
                           maxlength="120"
                           value="<c:out value='${expense.title}'/>"
                           placeholder="e.g. Lunch"
                           required>
                </div>

                <div class="form-group">
                    <label for="amount">Amount (₹)</label>
                    <input type="number"
                           id="amount"
                           name="amount"
                           min="0.01"
                           max="9999999999.99"
                           step="0.01"
                           value="<c:out value='${expense.amount}'/>"
                           placeholder="150.00"
                           required>
                </div>

                <div class="form-group">
                    <label for="category">Category</label>
                    <select id="category" name="category" required>
                        <option value="">Select category</option>

                        <option value="Food"
                            ${expense.category == 'Food' ? 'selected' : ''}>
                            Food
                        </option>

                        <option value="Transport"
                            ${expense.category == 'Transport' ? 'selected' : ''}>
                            Transport
                        </option>

                        <option value="Shopping"
                            ${expense.category == 'Shopping' ? 'selected' : ''}>
                            Shopping
                        </option>

                        <option value="Education"
                            ${expense.category == 'Education' ? 'selected' : ''}>
                            Education
                        </option>

                        <option value="Entertainment"
                            ${expense.category == 'Entertainment' ? 'selected' : ''}>
                            Entertainment
                        </option>

                        <option value="Other"
                            ${expense.category == 'Other' ? 'selected' : ''}>
                            Other
                        </option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="expenseDate">Expense date</label>
                    <input type="date"
                           id="expenseDate"
                           name="expenseDate"
                           value="<c:out value='${expense.expenseDate}'/>"
                           required>
                </div>

                <div class="form-group">
                    <label for="notes">Notes (optional)</label>
                    <textarea id="notes"
                              name="notes"
                              maxlength="2000"
                              placeholder="Additional details"><c:out value="${expense.notes}"/></textarea>
                </div>

                <button type="submit" class="button">
                    + Add Expense
                </button>

            </form>
        </div>

        <!-- Expense List -->
        <div class="card">
            <h2>Expense History</h2>

            <c:choose>
                <c:when test="${not empty expenses}">
                    <div class="table-wrapper">
                        <table>
                            <thead>
                            <tr>
                                <th>Title</th>
                                <th>Category</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Actions</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach items="${expenses}"
                                       var="expenseItem">

                                <tr>
                                    <td>
                                        <strong>
                                            <c:out value="${expenseItem.title}"/>
                                        </strong>

                                        <c:if test="${not empty expenseItem.notes}">
                                            <div class="muted">
                                                <c:out value="${expenseItem.notes}"/>
                                            </div>
                                        </c:if>
                                    </td>

                                    <td>
                                        <span class="category">
                                            <c:out value="${expenseItem.category}"/>
                                        </span>
                                    </td>

                                    <td>
                                        <c:out value="${expenseItem.expenseDate}"/>
                                    </td>

                                    <td class="amount">
                                        ₹<fmt:formatNumber
                                            value="${expenseItem.amount}"
                                            minFractionDigits="2"
                                            maxFractionDigits="2"/>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/expenses/edit/${expenseItem.id}">
                                            Edit
                                        </a>
                                    </td>
                                    <td>
                                        <form
                                            action="${pageContext.request.contextPath}/expenses/delete"
                                            method="post"
                                            onsubmit="return confirm('Are you sure you want to delete this expense?');">

                                            <input type="hidden"
                                                   name="id"
                                                   value="${expenseItem.id}">

                                            <button type="submit" class="delete-button">
                                                Delete
                                            </button>
                                        </form>
                                    </td>
                                </tr>

                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="empty-state">
                        <h3>No expenses yet</h3>
                        <p class="muted">
                            Add your first expense using the form.
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </section>

</main>

<footer class="footer">
    SplitWise — Manage your money together.
</footer>

</body>
</html>

