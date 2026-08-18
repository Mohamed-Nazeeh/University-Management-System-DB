-------- Content Posts 14,15,16 --------
Create Database UniversityManagementSystem

Use UniversityManagementSystem

Create Table Departments 
(
	DepartmentID Int Identity (1,1) 
		ConstraInt PK_Departments Primary Key,

    DepartmentName Varchar(100) Not Null,

    DepartmentCode Varchar(20) Not Null 
		ConstraInt UQ_Departments_Code Unique,

    OfficeLocation Varchar(100),

    Phone Varchar(20),

	CreatedAt Datetime2 Not Null 
		ConstraInt DF_Departments_CreatedAt 
		Default GETDATE()
);

Create Table Student
(
	StudentID Int Identity(1,1)
		ConstraInt PK_Student Primary Key,

	LastName Varchar(50) Not Null,

	FirstName Varchar(50) Not Null,

	Email Varchar(100) Not Null
		ConstraInt UQ_Student_Email Unique,

	DateOfBirth Date Not Null,

	Gender Char(1) Not Null
		ConstraInt CK_Student_Gender Check (Gender IN ('M', 'F')),

	EnrollmentDate Date Not Null
		ConstraInt DF_Student_EnrollmentDate Default Cast(GETDATE() AS Date),

	DepartmentID Int Not Null,

	ConstraInt FK_Student_Department
		Foreign Key (DepartmentID) References Departments(DepartmentID)
);


Create Table Instructor
(
	InstructorID Int Identity(1,1)
		ConstraInt PK_Instructor Primary Key,

	FirstName Varchar(50) Not Null,

	LastName Varchar(50) Not Null,

	Email Varchar(100) Not Null
		ConstraInt UQ_Instructor_Email Unique,

	Phone Varchar(20),

	HireDate Date Not Null,

	Salary Decimal(10,2) Not Null
		ConstraInt CK_Instructor_Salary Check (Salary > 0),

	DepartmentID Int Not Null,

	ConstraInt FK_Instructor_Department
		Foreign Key (DepartmentID) References DEPARTMENTS(DepartmentID)
);

Create Table Course
(
	CourseID Int Identity(1,1)
		ConstraInt PK_Course Primary Key,

	CourseName Varchar(100) Not Null,

	CourseCode Varchar(20) Not Null
		ConstraInt UQ_Course_Code Unique,

	CreditHours Int Not Null
		ConstraInt CK_Course_CreditHours Check (CreditHours > 0),

	DepartmentID Int Not Null,

	ConstraInt FK_Course_Department
		Foreign Key (DepartmentID) References DEPARTMENTS(DepartmentID)
);

Create Table Classroom
(
	ClassroomID Int Identity(1,1)
		ConstraInt PK_Classroom Primary Key,

	Capacity Int Not Null
		ConstraInt CK_Classroom_Capacity Check (Capacity > 0),

	RoomNumber Varchar(20) Not Null,

	Building Varchar(100) Not Null
);

Create Table Student_Phone
(
	Phone Varchar(20) Not Null,

	StudentID Int Not Null,

	ConstraInt PK_StudentPhone
		Primary Key (Phone, StudentID),

	ConstraInt FK_StudentPhone_Student
		Foreign Key (StudentID) References STUDENT(StudentID)
);

Create Table Enrollment
(
	EnrollmentID Int Identity(1,1)
	ConstraInt PK_Enrollment Primary Key,

	EnrollmentDate Date Not Null
		ConstraInt DF_Enrollment_Date Default Cast(GETDATE() AS Date),

	Grade Decimal(5,2),

	StudentID Int Not Null,

	CourseID Int Not Null,

	ConstraInt FK_Enrollment_Student
		Foreign Key (StudentID) References STUDENT(StudentID),

	ConstraInt FK_Enrollment_Course
		Foreign Key (CourseID) References COURSE(CourseID),

	ConstraInt CK_Enrollment_Grade
		Check (Grade Is Null Or Grade Between 0 And 100)
);

Create Table CourseSchedule
(
	ScheduleID Int Identity(1,1)
		ConstraInt PK_CourseSchedule Primary Key,

	DayOfWeek Varchar(15) Not Null,

	StartTime Time Not Null,

	EndTime Time Not Null,

	Semester Varchar(20) Not Null,

	InstructorID Int Not Null,

	CourseID Int Not Null,

	ClassroomID Int Not Null,

		ConstraInt FK_CourseSchedule_Instructor
		Foreign Key (InstructorID) 
		References Instructor(InstructorID),

		ConstraInt FK_CourseSchedule_Course
		Foreign Key (CourseID) 
		References Course(CourseID),

	    ConstraInt FK_CourseSchedule_Classroom
		Foreign Key (ClassroomID) 
		References Classroom(ClassroomID),

	ConstraInt CK_CourseSchedule_Time
		Check (EndTime > StartTime)
);

-------- Content Post 17 --------

-- Insert --
Insert Into Departments
(
    DepartmentName,
    DepartmentCode,
    OfficeLocation,
    Phone
)
Values
(
    'Computer Science', 'CS', 'Building A - Floor 2', '01010000001'
),
(
    'Information Technology', 'IT', 'Building A - Floor 3', '01010000002'
),
(
    'Information Systems', 'IS', 'Building B - Floor 1', '01010000003'
),
(
    'Software Engineering', 'SE', 'Building B - Floor 2', '01010000004'
),
(
    'Artificial Intelligence', 'AI', 'Building C - Floor 1', '01010000005'
);

Insert Into Student
(
    LastName,
    FirstName,
    Email,
    DateOfBirth,
    Gender,
    EnrollmentDate,
    DepartmentID
)
Values
(
    'Hassan', 'Omar', 'omar.hassan@example.com', '2003-05-12', 'M', '2025-09-15', 1
),
(
    'Ali', 'Ahmed', 'ahmed.ali@example.com', '2002-11-20', 'M', '2025-09-15', 1
),
(
    'Mohamed', 'Youssef', 'youssef.mohamed@example.com', '2004-02-08', 'M', '2025-09-16', 2
),
(
    'Ibrahim', 'Mariam', 'mariam.ibrahim@example.com', '2003-07-19', 'F', '2025-09-16', 3
),
(
    'Mahmoud', 'Karim', 'karim.mahmoud@example.com', '2002-03-25', 'M', '2025-09-17', 4
),
(
    'Samir', 'Nour', 'nour.samir@example.com', '2004-09-14', 'F', '2025-09-17', 5
),
(
    'Khaled', 'Mostafa', 'mostafa.khaled@example.com', '2003-12-03', 'M', '2025-09-18', 1
),
(
    'Adel', 'Salma', 'salma.adel@example.com', '2004-06-27', 'F', '2025-09-18', 2
),
(
    'Tarek', 'Omar', 'omar.tarek@example.com', '2003-01-11', 'M', '2025-09-19', 3
),
(
    'Nabil', 'Hana', 'hana.nabil@example.com', '2002-10-30', 'F', '2025-09-19', 4
);

Insert Into Instructor
(
    FirstName,
    LastName,
    Email,
    Phone,
    HireDate,
    Salary,
    DepartmentID
)
Values
(
    'Ahmed', 'Samir', 'ahmed.samir@example.com', '01110000001', '2018-09-01', 18000.00, 1
),
(
    'Mona', 'Hassan', 'mona.hassan@example.com', '01110000002', '2019-02-15', 16500.00, 2
),
(
    'Omar', 'Khaled', 'omar.khaled@example.com', '01110000003', '2020-01-10', 15000.00, 3
),
(
    'Sara', 'Mohamed', 'sara.mohamed@example.com', '01110000004', '2017-08-20', 19000.00, 4
),
(
    'Youssef', 'Adel', 'youssef.adel@example.com', '01110000005', '2021-03-12', 14500.00, 5
);

Insert Into Course
(
    CourseName,
    CourseCode,
    CreditHours,
    DepartmentID
)
Values
(
    'Database Systems', 'CS101', 3, 1
),
(
    'Data Structures', 'CS102', 3, 1
),
(
    'Web Development', 'IT101', 3, 2
),
(
    'Systems Analysis', 'IS101', 3, 3
),
(
    'Software Engineering', 'SE101', 3, 4
),
(
    'Machine Learning', 'AI101', 4, 5
);

Insert Into Classroom
(
    Capacity,
    RoomNumber,
    Building
)
Values
(
    40, 'A101', 'Building A'
),
(
    35, 'A102', 'Building A'
),
(
    50, 'B201', 'Building B'
),
(
    30, 'B202', 'Building B'
),
(
    45, 'C301', 'Building C'
);

Insert Into Student_Phone
(
    Phone,
    StudentID
)
Values
(
    '01220000001', 1
),
(
    '01220000002', 1
),
(
    '01220000003', 2
),
(
    '01220000004', 3
),
(
    '01220000005', 4
),
(
    '01220000006', 5
),
(
    '01220000007', 6
),
(
    '01220000008', 7
),
(
    '01220000009', 8
),
(
    '01220000010', 9
),
(
    '01220000011', 10
);

Insert Into Enrollment
(
    EnrollmentDate,
    Grade,
    StudentID,
    CourseID
)
Values
(
    '2025-09-20', 92.50, 1, 1
),
(
    '2025-09-20', 88.00, 1, 2
),
(
    '2025-09-20', 79.50, 2, 1
),
(
    '2025-09-21', 91.00, 3, 3
),
(
    '2025-09-21', 85.50, 4, 4
),
(
    '2025-09-21', 94.00, 5, 5
),
(
    '2025-09-22', 87.00, 6, 6
),
(
    '2025-09-22', 90.50, 7, 1
),
(
    '2025-09-22', 82.00, 8, 3
),
(
    '2025-09-23', 95.00, 9, 4
),
(
    '2025-09-23', 89.50, 10, 5
);

Insert Into CourseSchedule
(
    DayOfWeek,
    StartTime,
    EndTime,
    Semester,
    InstructorID,
    CourseID,
    ClassroomID
)
Values
(
    'Sunday', '09:00', '11:00', 'Fall 2025', 1, 1, 1
),
(
    'Monday', '10:00', '12:00', 'Fall 2025', 1, 2, 2
),
(
    'Tuesday', '09:00', '11:00', 'Fall 2025', 2, 3, 3
),
(
    'Wednesday', '11:00', '13:00', 'Fall 2025', 3, 4, 4
),
(
    'Thursday', '09:00', '12:00', 'Fall 2025', 4, 5, 3
),
(
    'Sunday', '12:00', '14:00', 'Fall 2025', 5, 6, 5
);

-- Update -- 
Update Departments
Set Phone = '01019999999'
Where DepartmentID = 1;

Update Instructor
Set Salary = 20000.00
Where InstructorID = 1;

Update Enrollment
Set Grade = 95.00
Where EnrollmentID = 1;

Update Classroom
Set
    Capacity = 55,
    Building = 'Building A - New Wing'
Where ClassroomID = 1;

-- Delete --
Delete From Student_Phone
Where Phone = '01220000002'
And StudentID = 1;

Delete From Enrollment
Where EnrollmentID = 2;

Delete From Student_Phone
Where StudentID = 1;
Delete From Enrollment
Where StudentID = 1;
Delete From Student
Where StudentID = 1;

-------- Content Post 18 --------
Select *
From Student;

Select
    StudentID,
    FirstName,
    LastName,
    Email
From Student;

Select
    StudentID,
    FirstName,
    LastName,
    DepartmentID
From Student
Where DepartmentID = 1;

Select
    StudentID,
    FirstName,
    LastName,
    Gender
From Student
Where Gender = 'F';

Select
    InstructorID,
    FirstName,
    LastName,
    Salary
From Instructor
Where Salary > 16000;

Select
    StudentID,
    FirstName,
    LastName
From Student
Order By LastName Asc;


Select
    StudentID,
    FirstName,
    LastName
From Student

Order By LastName Asc;

Select
    StudentID,
    FirstName,
    LastName,
    Email
From Student
Where DepartmentID = 1
Order By LastName Asc;


Select
    InstructorID,
    FirstName,
    LastName,
    Salary

From Instructor
Where Salary > 15000
Order By Salary Desc;

-- Distinct --
Select Distinct
    DepartmentID
From Student;

Select Distinct
    Gender
From Student;

Select Distinct
    CreditHours
From Course;

-- Top -- 
Select Top 5
    StudentID,
    FirstName,
    LastName,
    Email
From Student;

Select Top 3
    InstructorID,
    FirstName,
    LastName,
    Salary
From Instructor
Order By Salary Desc;

Select Top 3
    StudentID,
    CourseID,
    Grade
From Enrollment

Where Grade Is Not Null

Order By Grade Desc;

Select Top 3
    CourseID,
    CourseName,
    CreditHours
From Course

Order By CreditHours Desc;