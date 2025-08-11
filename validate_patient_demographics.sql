-- File: validate_patient_demographics.sql

CREATE PROCEDURE ValidatePatientDemographics
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        PatientID,
        FirstName,
        LastName,
        DateOfBirth,
        Gender,
        CASE 
            WHEN FirstName IS NULL OR LastName IS NULL THEN 'Missing Name'
            WHEN DateOfBirth IS NULL THEN 'Missing DOB'
            WHEN Gender NOT IN ('Male', 'Female', 'Other') THEN 'Invalid Gender'
            ELSE 'Valid'
        END AS ValidationStatus
    FROM PatientDemographics
    WHERE IsActive = 1;
END;
