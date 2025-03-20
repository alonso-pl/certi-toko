module{
    public type Student = {
        id: Nat;
        last_name: Text;
        first_name: Text;
    };

    public type Teacher = {
        id: Nat;
        last_name: Text;
        first_name: Text;
    };

    public type Course = {
        id: Nat;
        name: Text;
        teacher: Teacher;
        hours: Nat;
    };

    public type Enrollment = {
        student: Student;
        course: Course;
        status: Text;
    };
    public type Certificate = {
        id: Nat;
        student: Student;
        course: Course;
        date: Date;
    };

    public type Date = {
        year: Nat;
        month: Nat;
        day: Nat;
    };
    
}