using { edu.university as uni } from '../db/schema';

service UniversityService {

    entity Departments  as projection on uni.Departments;
    entity Professors   as projection on uni.Professors;
    entity Courses      as projection on uni.Courses;
    entity Students     as projection on uni.Students;
    entity Enrollments  as projection on uni.Enrollments;
    entity Exams        as projection on uni.Exams;

}