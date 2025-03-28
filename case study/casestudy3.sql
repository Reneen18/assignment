CREATE TABLE Tax (
    TaxID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    TaxYear INT NOT NULL,
    TaxableIncome DECIMAL(10,2) NOT NULL,
    TaxAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID) ON DELETE CASCADE
);
