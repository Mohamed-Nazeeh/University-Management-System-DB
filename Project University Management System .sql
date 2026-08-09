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
		ConstraInt DF_Departments_CreatedAt Default GETDATE()
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
		Foreign Key (InstructorID) References Instructor(InstructorID),

	ConstraInt FK_CourseSchedule_Course
		Foreign Key (CourseID) References Course(CourseID),

	ConstraInt FK_CourseSchedule_Classroom
		Foreign Key (ClassroomID) References Classroom(ClassroomID),

	ConstraInt CK_CourseSchedule_Time
		Check (EndTime > StartTime)
);






