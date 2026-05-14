import sys
import subprocess

def install(package):
    subprocess.check_call([sys.executable, "-m", "pip", "install", package, "--user"])

try:
    import pypdf
except ImportError:
    install('pypdf')
    import pypdf

reader = pypdf.PdfReader("Saloon PG idea (1).pdf")
text = ""
for page in reader.pages:
    text += page.extract_text() + "\n"

with open("pdf_content.txt", "w", encoding="utf-8") as f:
    f.write(text)
print("Extracted to pdf_content.txt")
