import os
import re

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon\src\main\java\com\salon"

# Map of class names to their fully qualified package name
class_packages = {
    "FileHandler": "com.salon.common.FileHandler",
    "QuickSort": "com.salon.common.QuickSort",
    "Booking": "com.salon.booking.Booking",
    "BookingService": "com.salon.booking.BookingService",
    "BookingQueue": "com.salon.booking.BookingQueue",
    "Customer": "com.salon.customer.Customer",
    "CustomerService": "com.salon.customer.CustomerService",
    "Employee": "com.salon.employee.Employee",
    "EmployeeService": "com.salon.employee.EmployeeService",
    "Review": "com.salon.review.Review",
    "ReviewService": "com.salon.review.ReviewService",
    "Service": "com.salon.service.Service",
    "ServiceService": "com.salon.service.ServiceService",
    "ServletContext": "jakarta.servlet.ServletContext"
}

def add_imports(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    lines = content.split('\n')
    package_line_idx = -1
    for i, line in enumerate(lines):
        if line.startswith('package '):
            package_line_idx = i
            break

    if package_line_idx == -1:
        return

    added_imports = False
    
    # Check for each class if it's used in the file
    for cls, fqcn in class_packages.items():
        # Only check if the file is NOT in the same package (actually it doesn't hurt to add the import anyway, unless it's the exact same class)
        # But let's check if the class name is used as a whole word
        if re.search(r'\b' + cls + r'\b', content):
            # Check if import already exists
            import_statement = f"import {fqcn};"
            if import_statement not in content and not content.endswith(import_statement):
                # Don't import yourself
                if not filepath.endswith(cls + ".java"):
                    lines.insert(package_line_idx + 1, import_statement)
                    added_imports = True

    if added_imports:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write('\n'.join(lines))
        print(f"Added imports to {filepath}")

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith(".java"):
            add_imports(os.path.join(root, file))

print("Missing imports added.")
