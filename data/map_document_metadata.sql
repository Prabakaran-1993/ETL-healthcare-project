-- File: map_document_metadata.sql

CREATE PROCEDURE MapDocumentMetadata
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE PatientDocuments
    SET DocumentType = CASE 
        WHEN FileName LIKE '%lab%' THEN 'Lab Report'
        WHEN FileName LIKE '%visit%' THEN 'Visit Summary'
        WHEN FileName LIKE '%rx%' THEN 'Prescription'
        WHEN FileName LIKE '%discharge%' THEN 'Discharge Summary'
        ELSE 'Unknown'
    END,
    MappedDate = GETDATE()
    WHERE DocumentType IS NULL;
END;

/*🔍 What This Does
Automatically maps document types based on filename patterns

Updates the MappedDate to track when mapping occurred

Reflects your automation work using Python and SQL for metadata extraction*/
