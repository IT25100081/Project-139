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

    # Replace occurrences like "login.jsp" or "/login.jsp" with "/customer/login.jsp"
    for jsp_file, new_path in jsp_paths.items():
        # This regex matches the jsp file name surrounded by quotes, possibly preceded by a slash
        # It handles both "login.jsp" and "/login.jsp"
        pattern = r'(["\'])/?' + re.escape(jsp_file) + r'(["\'])'
        replacement = r'\1' + new_path + r'\2'
        content = re.sub(pattern, replacement, content)

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
