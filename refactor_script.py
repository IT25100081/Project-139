import os
import shutil

base_dir = r"c:\Users\ASUS\OneDrive\Desktop\NEW\Glamour-Haven-Beauty-Salon"
java_base = os.path.join(base_dir, "src", "main", "java", "com", "salon")
webapp_base = os.path.join(base_dir, "src", "main", "webapp")

java_moves = {
    # admin
    "controller/AdminController.java": "admin/AdminController.java",
    "controller/AdminDashboardController.java": "admin/AdminDashboardController.java",
    # booking
    "controller/BookingController.java": "booking/BookingController.java",
    "model/Booking.java": "booking/Booking.java",
    "service/BookingService.java": "booking/BookingService.java",
    "util/BookingQueue.java": "booking/BookingQueue.java",
    # customer
    "controller/CustomerController.java": "customer/CustomerController.java",
    "model/Customer.java": "customer/Customer.java",
    "service/CustomerService.java": "customer/CustomerService.java",
    # employee
    "controller/EmployeeController.java": "employee/EmployeeController.java",
    "model/Employee.java": "employee/Employee.java",
    "service/EmployeeService.java": "employee/EmployeeService.java",
    # review
    "controller/ReviewController.java": "review/ReviewController.java",
    "model/Review.java": "review/Review.java",
    "service/ReviewService.java": "review/ReviewService.java",
    # service
    "controller/ServiceController.java": "service/ServiceController.java",
    "model/Service.java": "service/Service.java",
    "service/ServiceService.java": "service/ServiceService.java",
    # common
    "controller/HomeController.java": "common/HomeController.java",
    "service/FileHandler.java": "common/FileHandler.java",
    "util/QuickSort.java": "common/QuickSort.java"
}

jsp_moves = {
    # admin
    "adminDashboard.jsp": "admin/adminDashboard.jsp",
    # booking
    "bookingConfirmation.jsp": "booking/bookingConfirmation.jsp",
    "bookingDetails.jsp": "booking/bookingDetails.jsp",
    "bookingForm.jsp": "booking/bookingForm.jsp",
    "bookingManagement.jsp": "booking/bookingManagement.jsp",
    "bookings.jsp": "booking/bookings.jsp",
    # customer
    "editProfile.jsp": "customer/editProfile.jsp",
    "profile.jsp": "customer/profile.jsp",
    "userDashboard.jsp": "customer/userDashboard.jsp",
    "userDetails.jsp": "customer/userDetails.jsp",
    "userManagement.jsp": "customer/userManagement.jsp",
    "login.jsp": "customer/login.jsp",
    "register.jsp": "customer/register.jsp",
    # employee
    "employeeDetails.jsp": "employee/employeeDetails.jsp",
    "employeeManagement.jsp": "employee/employeeManagement.jsp",
    # review
    "reviewConfirmation.jsp": "review/reviewConfirmation.jsp",
    "reviewForm.jsp": "review/reviewForm.jsp",
    # service
    "serviceDetails.jsp": "service/serviceDetails.jsp",
    "serviceForm.jsp": "service/serviceForm.jsp",
    "serviceManagement.jsp": "service/serviceManagement.jsp",
    "serviceTable.jsp": "service/serviceTable.jsp",
    "services.jsp": "service/services.jsp"
}

# Create new directories
new_java_dirs = ["admin", "booking", "customer", "employee", "review", "service", "common"]
for d in new_java_dirs:
    os.makedirs(os.path.join(java_base, d), exist_ok=True)
    os.makedirs(os.path.join(webapp_base, d), exist_ok=True)

# Move java files
for src, dst in java_moves.items():
    src_path = os.path.join(java_base, os.path.normpath(src))
    dst_path = os.path.join(java_base, os.path.normpath(dst))
    if os.path.exists(src_path):
        print(f"Moving {src_path} -> {dst_path}")
        shutil.move(src_path, dst_path)

# Move jsp files
for src, dst in jsp_moves.items():
    src_path = os.path.join(webapp_base, os.path.normpath(src))
    dst_path = os.path.join(webapp_base, os.path.normpath(dst))
    if os.path.exists(src_path):
        print(f"Moving {src_path} -> {dst_path}")
        shutil.move(src_path, dst_path)

print("Files moved successfully.")
