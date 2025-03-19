module{
    type Student = {
        id: Nat;
        last_name: Text;
        first_name: Text;
    };

    type Teacher = {
        id: Nat;
        last_name: Text;
        first_name: Text;
    };

    type Course = {
        id: Nat;
        name: Text;
        teacher: Teacher;
    };

    type Enrollment = {
        id: Nat;
        student: Student;
        course: Course;
    };
    type Certificate = {
        id: Nat;
        student: Student;
        course: Course;
        date: Date;
    };

    type Date = {
        year: Nat;
        month: Nat;
        day: Nat;
    };
    
}