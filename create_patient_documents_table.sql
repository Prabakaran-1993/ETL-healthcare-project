-- File: create_patient_documents_table.sql

CREATE TABLE PatientDocuments (
    DocumentID INT IDENTITY(1,1) PRIMARY KEY,
    ClaimID VARCHAR(50),
    FilePath VARCHAR(255),
    MappedDate DATETIME
);
