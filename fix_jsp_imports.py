import os
import re

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon\src\main\webapp"

class_package_map = {
    "Booking": "com.salon.booking.Booking",
    "Customer": "com.salon.customer.Customer",
    "Employee": "com.salon.employee.Employee",
    "Review": "com.salon.review.Review",
    "Service": "com.salon.service.Service",
}

def fix_jsp_imports(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    original = content

    for class_name, new_fqcn in class_package_map.items():
        # Match com.salon.model.ClassName or com.salon.service.ClassName
        old_pattern = r'com\.salon\.(model|service|controller|util)\.' + class_name
        content = re.sub(old_pattern, new_fqcn, content)

    if content != original:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated imports in {filepath}")

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".jsp") or file.endswith(".jspf"):
            fix_jsp_imports(os.path.join(root, file))

print("JSP Java imports fixed.")
