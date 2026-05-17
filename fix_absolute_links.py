import os
import re

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon\src\main\webapp"

def fix_absolute_links(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    original = content

    # Replace href="/folder/file.jsp" with href="${pageContext.request.contextPath}/folder/file.jsp"
    # Match href="/(admin|booking|customer|employee|review|service)/..."
    pattern = r'href="/(admin|booking|customer|employee|review|service)/([^"]+)"'
    content = re.sub(pattern, r'href="${pageContext.request.contextPath}/\1/\2"', content)

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated absolute links in {filepath}")

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".jsp") or file.endswith(".jspf"):
            fix_absolute_links(os.path.join(root, file))

print("Absolute JSP links fixed.")
