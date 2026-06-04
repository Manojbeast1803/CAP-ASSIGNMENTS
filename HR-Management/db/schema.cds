namespace com.hr;

using { cuid, managed } from '@sap/cds/common';

type ProjectStatus : String(20) enum {
    Planning  = 'Planning';
    Active    = 'Active';
    OnHold    = 'On Hold';
    Completed = 'Completed';
    Cancelled = 'Cancelled';
}

type Proficiency : String(20) enum {
    Beginner     = 'Beginner';
    Intermediate = 'Intermediate';
    Advanced     = 'Advanced';
    Expert       = 'Expert';
}

type SkillCategory : String(30) enum {
    Technical  = 'Technical';
    Soft       = 'Soft';
    Management = 'Management';
    Domain     = 'Domain';
}

entity Departments : cuid, managed {
    deptName    : String(100);
    description : String(500);
    budget      : Decimal(15,2);
    location    : String(100);
}

entity Employees : cuid, managed {
    firstName   : String(50);
    lastName    : String(50);
    email       : String(100);
    phone       : String(20);
    hireDate    : Date;
    salary      : Decimal(15,2);
    jobTitle    : String(100);
    isActive    : Boolean default true;

    department  : Association to Departments;
}

entity Projects : cuid, managed {
    projectName : String(100);
    description : String(500);
    startDate   : Date;
    endDate     : Date;
    budget      : Decimal(15,2);
    status      : ProjectStatus;

    manager     : Association to Employees;
}

entity Skills : cuid, managed {
    skillName   : String(100);
    category    : SkillCategory;
    description : String(500);
}

entity Assignments : cuid, managed {
    employee          : Association to Employees;
    project           : Association to Projects;
    role              : String(100);
    allocationPercent : Integer;
}

entity EmployeeSkills : cuid, managed {
    employee     : Association to Employees;
    skill        : Association to Skills;
    proficiency  : Proficiency;
}