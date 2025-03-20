WITH RECURSIVE Subordinates AS (
    SELECT
        EmployeeID,
        Name as EmployeeName,
        ManagerID,
        DepartmentID,
        RoleID
    FROM Employees
    WHERE ManagerID = 1

    UNION ALL

    SELECT
        e.EmployeeID,
        e.Name,
        e.ManagerID,
        e.DepartmentID,
        e.RoleID
    FROM Employees e
             INNER JOIN Subordinates s
                        ON e.ManagerID = s.EmployeeID
)
SELECT
    s.EmployeeID,
    s.EmployeeName,
    s.ManagerID,
    d.DepartmentName,
    r.RoleName,
    COALESCE(
            (SELECT GROUP_CONCAT(p.ProjectName ORDER BY p.ProjectName SEPARATOR ', ')
             FROM Projects p
             WHERE p.DepartmentID = s.DepartmentID),
            'NULL'
        ) AS ProjectNames,
    COALESCE(
            (SELECT GROUP_CONCAT(t.TaskName ORDER BY t.TaskName SEPARATOR ', ')
             FROM Tasks t
             WHERE t.AssignedTo = s.EmployeeID),
            'NULL'
        ) AS TaskNames,
    (SELECT COUNT(*)
     FROM Tasks t
     WHERE t.AssignedTo = s.EmployeeID) AS TotalTasks,

    (SELECT COUNT(*)
     FROM Employees e
     WHERE e.ManagerID = s.EmployeeID) AS TotalSubordinates
FROM Subordinates s
         LEFT JOIN Departments d
                   ON s.DepartmentID = d.DepartmentID
         LEFT JOIN Roles r
                   ON s.RoleID = r.RoleID
ORDER BY s.EmployeeName;