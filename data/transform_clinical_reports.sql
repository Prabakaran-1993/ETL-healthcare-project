-- File: transform_clinical_reports.sql

CREATE PROCEDURE TransformClinicalReports
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE ClinicalReports
    SET ReportText = REPLACE(REPLACE(REPLACE(ReportText, CHAR(13), ' '), CHAR(10), ' '), '  ', ' ')
    WHERE ReportText IS NOT NULL;
END;


/*This procedure cleans up the text in clinical reports by:

 Removing carriage returns (CHAR(13)) and line breaks (CHAR(10))

Replacing double spaces with single spaces

✅Ensuring the report text is more readable and standardized before migration or reporting

This kind of transformation is especially useful when:

You're replicating reports in RDLC or Power BI

You need consistent formatting across legacy systems

You're preparing data for downstream analytics or archiving*/
