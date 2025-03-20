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
    };

    public type Enrollment = {
        id: Nat;
        student: Student;
        course: Course;
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