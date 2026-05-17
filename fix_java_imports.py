import os
import re

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon\src\main\java\com\salon"

# Mapping from class name to its new package
class_package_map = {
    # admin
    "AdminController": "com.salon.admin",
    "AdminDashboardController": "com.salon.admin",
    # booking
    "BookingController": "com.salon.booking",
    "Booking": "com.salon.booking",
    "BookingService": "com.salon.booking",
    "BookingQueue": "com.salon.booking",
    # customer
    "CustomerController": "com.salon.customer",
    "Customer": "com.salon.customer",
    "CustomerService": "com.salon.customer",
    # employee
    "EmployeeController": "com.salon.employee",
    "Employee": "com.salon.employee",
    "EmployeeService": "com.salon.employee",
    # review
    "ReviewController": "com.salon.review",
    "Review": "com.salon.review",
    "ReviewService": "com.salon.review",
    # service
    "ServiceController": "com.salon.service",
    "Service": "com.salon.service",
    "ServiceService": "com.salon.service",
    # common
    "HomeController": "com.salon.common",
    "FileHandler": "com.salon.common",
    "QuickSort": "com.salon.common"
}

def process_file(filepath, feature_name):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Update package declaration
    content = re.sub(r'^package\s+com\.salon\.[a-zA-Z0-9_]+;', f'package com.salon.{feature_name};', content, flags=re.MULTILINE)

    # Update imports
    for class_name, pkg in class_package_map.items():
        # Match old imports like: import com.salon.model.Customer; or import com.salon.service.CustomerService;
        old_import_pattern = r'import\s+com\.salon\.[a-zA-Z0-9_]+\.' + class_name + r';'
        new_import = f'import {pkg}.{class_name};'
        content = re.sub(old_import_pattern, new_import, content)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".java"):
            filepath = os.path.join(root, file)
            # feature name is the folder name inside com/salon
            feature_name = os.path.basename(os.path.dirname(filepath))
            process_file(filepath, feature_name)
            print(f"Processed {filepath}")

print("Java files updated.")
