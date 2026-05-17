import os
import re

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon\src\main"
java_dir = os.path.join(base_dir, "java")
webapp_dir = os.path.join(base_dir, "webapp")

jsp_paths = {
    # admin
    "adminDashboard.jsp": "/admin/adminDashboard.jsp",
    # booking
    "bookingConfirmation.jsp": "/booking/bookingConfirmation.jsp",
    "bookingDetails.jsp": "/booking/bookingDetails.jsp",
    "bookingForm.jsp": "/booking/bookingForm.jsp",
    "bookingManagement.jsp": "/booking/bookingManagement.jsp",
    "bookings.jsp": "/booking/bookings.jsp",
    # customer
    "editProfile.jsp": "/customer/editProfile.jsp",
    "profile.jsp": "/customer/profile.jsp",
    "userDashboard.jsp": "/customer/userDashboard.jsp",
    "userDetails.jsp": "/customer/userDetails.jsp",
    "userManagement.jsp": "/customer/userManagement.jsp",
    "login.jsp": "/customer/login.jsp",
    "register.jsp": "/customer/register.jsp",
    # employee
    "employeeDetails.jsp": "/employee/employeeDetails.jsp",
    "employeeManagement.jsp": "/employee/employeeManagement.jsp",
    # review
    "reviewConfirmation.jsp": "/review/reviewConfirmation.jsp",
    "reviewForm.jsp": "/review/reviewForm.jsp",
    # service
    "serviceDetails.jsp": "/service/serviceDetails.jsp",
    "serviceForm.jsp": "/service/serviceForm.jsp",
    "serviceManagement.jsp": "/service/serviceManagement.jsp",
    "serviceTable.jsp": "/service/serviceTable.jsp",
    "services.jsp": "/service/services.jsp"
}

def replace_jsp_paths(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        original_content = content

    for jsp_file, new_path in jsp_paths.items():
        # Match cases like:
        # "login.jsp" or "/login.jsp"
        # request.getRequestDispatcher("login.jsp")
        # href="${pageContext.request.contextPath}/login.jsp"
        # action="login.jsp"
        
        # We can match the file name with an optional leading slash, 
        # preceded by either a quote or a closing brace `}`, 
        # and followed by a quote.
        
        pattern = r'([\"\'\}])/?' + re.escape(jsp_file) + r'([\"\'\?])'
        
        # Actually it's better to just look for the jsp_file as a word ending in .jsp
        # pattern2: anything before the jsp_file, we replace the jsp_file with new_path if it doesn't already have the new_path prefix
        # But a simple regex is:
        # replace `/?<jsp_file>` with `<new_path>` where it's not already `<new_path>`
        
        # regex to match /?login.jsp
        # negative lookbehind to ensure it's not already /customer/login.jsp
        # Wait, python's re module doesn't support variable length lookbehind.
        
        # Let's just do a simple replace of the specific string patterns we know
        
        # Pattern 1: exactly "login.jsp" or "/login.jsp"
        p1 = r'(["\'])/?' + re.escape(jsp_file) + r'(["\'])'
        content = re.sub(p1, r'\1' + new_path + r'\2', content)
        
        # Pattern 2: after context path
        p2 = r'(\$\{pageContext\.request\.contextPath\})/?' + re.escape(jsp_file) + r'(["\'\?])'
        content = re.sub(p2, r'\1' + new_path + r'\2', content)

        # Pattern 3: action="login.jsp"
        p3 = r'(action=["\'])/?' + re.escape(jsp_file) + r'(["\'])'
        content = re.sub(p3, r'\1' + new_path + r'\2', content)
        
        # Pattern 4: in java getRequestDispatcher
        p4 = r'(getRequestDispatcher\(\s*["\'])/?' + re.escape(jsp_file) + r'(["\'])'
        content = re.sub(p4, r'\1' + new_path + r'\2', content)
        
        # Pattern 5: sendRedirect
        p5 = r'(sendRedirect\(.*["\'])/?' + re.escape(jsp_file) + r'(["\'])'
        content = re.sub(p5, r'\1' + new_path + r'\2', content)

    if content != original_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated paths in {filepath}")

# Update Java files
for root, dirs, files in os.walk(java_dir):
    for file in files:
        if file.endswith(".java"):
            replace_jsp_paths(os.path.join(root, file))

# Update JSP files (and jspf)
for root, dirs, files in os.walk(webapp_dir):
    for file in files:
        if file.endswith(".jsp") or file.endswith(".jspf"):
            replace_jsp_paths(os.path.join(root, file))

print("JSP paths updated across Java and JSP files.")
