<%--
  Created by IntelliJ IDEA.
  User: siddh
  Date: 13-10-2026
  Time: 21:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SplitWise | Edit Expense</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #1e293b;
        }

        header {
            background: white;
            padding: 20px 6%;
            border-bottom: 1px solid #e5e7eb;
        }

        header a {
            color: #2563eb;
            text-decoration: none;
            font-size: 23px;
            font-weight: bold;
        }

        .container {
            max-width: 600px;
            margin: 40px auto;
            padding: 0 18px;
        }

        .card {
            background: white;
            padding: 28px;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
        }

        h1 {
            margin-top: 0;
            font-size: 25px;
        }

        .description {
            color: #64748b;
            margin-bottom: 25px;
            line-height: 1.5;
        }

        .field {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 7px;
            font-weight: bold;
            font-size: 14px;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #cbd5e1;
            border-radius: 7px;
            font: inherit;
        }

        textarea {
            resize: vertical;
            min-height: 90px;
        }

        .error {
            background: #fef2f2;
            color: #b91c1c;
            padding: 12px;
            border-radius: 7px;
            margin-bottom: 18px;
        }

        .buttons {
            display: flex;
            gap: 12px;
            margin-top: 24px;
        }

        .button {
            display: inline-block;
            padding: 12px 18px;
            border: none;
            border-radius: 7px;
            background: #2563eb;
            color: white;
            text-decoration: none;
            cursor: pointer;
            font-size: 14px;
            text-align: center;
        }

        .cancel {
            background: #e2e8f0;
            color: #334155;
        }
    </style>
</head>

<body>

<header>
    <a href="${pageContext.request.contextPath}/dashboard">
        SplitWise
    </a>
</header>

<main class="container">
    <div class="card">

        <h1>Edit Expense</h1>

        <p class="description">
            Update the details of your existing personal expense.
        </p>

        <c:if test="${not empty errorMessage}">
            <div class="error" role="alert">
                <c:out value="${errorMessage}"/>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/expenses/update"
              method="post">

            <input type="hidden"
                   name="id"
                   value="${expense.id}"/>

            <div class="field">
                <label for="title">Expense title</label>
                <input type="text"
                       id="title"
                       name="title"
                       maxlength="120"
                       value="${fn:escapeXml(expense.title)}"
                       required/>
            </div>

            <div class="field">
                <label for="amount">Amount (₹)</label>
                <input type="number"
                       id="amount"
                       name="amount"
                       min="0.01"
                       max="9999999999.99"
                       step="0.01"
                       value="${expense.amount}"
                       required/>
            </div>

            <div class="field">
                <label for="category">Category</label>
                <select id="category" name="category" required>
                    <option value="">Select category</option>

                    <option value="Food"
                        <c:if test="${expense.category eq 'Food'}">selected</c:if>>
                        Food
                    </option>

                    <option value="Transport"
                        <c:if test="${expense.category eq 'Transport'}">selected</c:if>>
                        Transport
                    </option>

                    <option value="Shopping"
                        <c:if test="${expense.category eq 'Shopping'}">selected</c:if>>
                        Shopping
                    </option>

                    <option value="Education"
                        <c:if test="${expense.category eq 'Education'}">selected</c:if>>
                        Education
                    </option>

                    <option value="Entertainment"
                        <c:if test="${expense.category eq 'Entertainment'}">selected</c:if>>
                        Entertainment
                    </option>

                    <option value="Other"
                        <c:if test="${expense.category eq 'Other'}">selected</c:if>>
                        Other
                    </option>
                </select>
            </div>

            <div class="field">
                <label for="expenseDate">Expense date</label>
                <input type="date"
                       id="expenseDate"
                       name="expenseDate"
                       value="${expense.expenseDate}"
                       required/>
            </div>

            <div class="field">
                <label for="notes">Notes</label>
                <textarea id="notes"
                          name="notes"
                          maxlength="2000"><c:out value="${expense.notes}"/></textarea>
            </div>

            <div class="buttons">
                <button type="submit" class="button">
                    Save Changes
                </button>

                <a class="button cancel"
                   href="${pageContext.request.contextPath}/expenses">
                    Cancel
                </a>
            </div>

        </form>
    </div>
</main>

</body>
</html>

