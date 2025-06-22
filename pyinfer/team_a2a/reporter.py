# analysis/reporter.py
from xhtml2pdf import pisa

def generate_pdf(content, filename):
    with open(filename, "w+b") as f:
        pisa.CreatePDF(content, dest=f)
        
def save_markdown(content, filename):
    with open(filename, "w") as f:
        f.write(content)