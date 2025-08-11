import os
import re
import xml.etree.ElementTree as ET
from fpdf import FPDF
import pyodbc

# Configuration
input_folder = "era_files"
output_folder = "patient_pdfs"
delimiter = "-------------------------------"
sql_conn_str = "DRIVER={SQL Server};SERVER=your_server;DATABASE=your_db;UID=user;PWD=password"

# Ensure output folder exists
os.makedirs(output_folder, exist_ok=True)

def extract_claim_id(text):
    match = re.search(r"Claim ID[:\s]+(\w+)", text)
    return match.group(1) if match else None

def save_as_pdf(text, filename):
    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", size=10)
    for line in text.splitlines():
        pdf.cell(200, 5, txt=line, ln=True)
    pdf.output(filename)

def map_to_database(claim_id, pdf_path):
    conn = pyodbc.connect(sql_conn_str)
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO PatientDocuments (ClaimID, FilePath, MappedDate)
        VALUES (?, ?, GETDATE())
    """, claim_id, pdf_path)
    conn.commit()
    conn.close()

# Process each XML file
for file_name in os.listdir(input_folder):
    if file_name.endswith(".xml"):
        file_path = os.path.join(input_folder, file_name)
        with open(file_path, "r", encoding="utf-8") as file:
            content = file.read()
            sections = content.split(delimiter)
            for i, section in enumerate(sections):
                claim_id = extract_claim_id(section)
                if claim_id:
                    pdf_name = f"{claim_id}.pdf"
                    pdf_path = os.path.join(output_folder, pdf_name)
                    save_as_pdf(section, pdf_path)
                    map_to_database(claim_id, pdf_path)
