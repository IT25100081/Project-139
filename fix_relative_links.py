import os
import re

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon\src\main\webapp"

# Known root resources that might be linked relatively
root_resources = [
    r"index\.jsp",
    r"about\.jsp",
    r"privacy-policy\.jsp",
    r"css/[^\"]+",
    r"images/[^\"]+",
    r"js/[^\"]+"
]

def fix_links(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    original = content

    for res in root_resources:
        # href="index.jsp" -> href="${pageContext.request.contextPath}/index.jsp"
        # make sure it doesn't already have ${pageContext... or a slash before it
        pattern_href = r'href="(?!\$\{pageContext\.request\.contextPath\}|/)(' + res + r')"'
        content = re.sub(pattern_href, r'href="${pageContext.request.contextPath}/\1"', content)

        # src="images/..." -> src="${pageContext.request.contextPath}/images/..."
        pattern_src = r'src="(?!\$\{pageContext\.request\.contextPath\}|/)(' + res + r')"'
        content = re.sub(pattern_src, r'src="${pageContext.request.contextPath}/\1"', content)

    # Also let's fix any remaining relative actions that just specify the controller name without slash
    # e.g. action="BookingController" -> action="${pageContext.request.contextPath}/BookingController"
    action_pattern = r'action="(?!\$\{pageContext\.request\.contextPath\}|/)([A-Za-z]+Controller.*)"'
    content = re.sub(action_pattern, r'action="${pageContext.request.contextPath}/\1"', content)
    
    # And href="BookingController..." 
    href_controller_pattern = r'href="(?!\$\{pageContext\.request\.contextPath\}|/)([A-Za-z]+Controller.*)"'
    content = re.sub(href_controller_pattern, r'href="${pageContext.request.contextPath}/\1"', content)


    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated links in {filepath}")

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".jsp") or file.endswith(".jspf"):
            fix_links(os.path.join(root, file))

print("All relative JSP links fixed.")
