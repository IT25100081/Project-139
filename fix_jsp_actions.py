import os
import re

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon\src\main\webapp"

def fix_jsp_links(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    original = content

    # Replace action="XyzController..." with action="${pageContext.request.contextPath}/XyzController..."
    # But only if it doesn't already start with ${pageContext.request.contextPath} or /
    action_pattern = r'action="(?!\$\{pageContext\.request\.contextPath\}|/)([A-Za-z]+Controller)'
    content = re.sub(action_pattern, r'action="${pageContext.request.contextPath}/\1', content)

    # Replace href="XyzController..." with href="${pageContext.request.contextPath}/XyzController..."
    href_pattern = r'href="(?!\$\{pageContext\.request\.contextPath\}|/)([A-Za-z]+Controller)'
    content = re.sub(href_pattern, r'href="${pageContext.request.contextPath}/\1', content)

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated links in {filepath}")

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".jsp") or file.endswith(".jspf"):
            fix_jsp_links(os.path.join(root, file))

print("JSP links fixed.")
