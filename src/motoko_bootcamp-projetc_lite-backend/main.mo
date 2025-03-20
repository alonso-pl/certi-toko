import Types "./types";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
actor {
  
  let students = HashMap.HashMap<Text, Types.Student>(0, Text.equal, Text.hash);
  let teachers = HashMap.HashMap<Text, Types.Teacher>(0, Text.equal, Text.hash);
  let courses = HashMap.HashMap<Text, Types.Course>(0, Text.equal, Text.hash);
  let enrollments = HashMap.HashMap<Text, Types.Enrollment>(0, Text.equal, Text.hash);
  let certificates = HashMap.HashMap<Text, Types.Certificate>(0, Text.equal, Text.hash);

  // convert to stable memory when implement [mops - map]
  var student_id : Nat = 0;
  var teacher_id : Nat = 0;
  var course_id : Nat = 0;
  var certificate_id : Nat = 0;
  
  // private function to generate a new student id
  private func new_stundet_id() : Nat {
    student_id += 1;
    return student_id;
  };

  // public function to create a new student
  public func new_student(first_name: Text, last_name: Text) : async Text {
    let new_student: Types.Student = {
      id = new_stundet_id();
      first_name = first_name;
      last_name = last_name;
    };
    students.put(Nat.toText(new_student.id), new_student);
    return "New studend added whit ID: " # Nat.toText(new_student.id);
  };

  // public function to get a student by id
  public query func get_student(id: Nat) : async ?Types.Student {
    switch (students.get(Nat.toText(id))) {
      case (null) {
        Debug.print("Student not found");
        return null; };
      case (_student) { return students.get(Nat.toText(id)); };
    };
  };

  // public function to update a student by id
  public func update_student(id: Nat, first_name: Text, last_name: Text) : async Text {
    let student = students.get(Nat.toText(id));
    switch (student) {
      case (null) {
        return "Student not found";
      };
      case (?student) {
        let updated_student: Types.Student = {
          id = student.id;
          first_name = if (first_name == "") student.first_name else first_name;
          last_name = if (last_name == "") student.last_name else last_name;
        };
        students.put(Nat.toText(updated_student.id), updated_student);
        return "Student updated";
      };
    };
  };
  
  // public function to delete a student by id
  public func delete_student(id: Nat) : async Text {
    switch (students.get(Nat.toText(id))) {
      case (null) {
        Debug.print("Student not found");
        return "Student not found"; };
      case (_) {
        ignore students.remove(Nat.toText(id));
        return "Student deleted"; };
    };
  };


  // private function to generate a new teacher id
  private func new_teacher_id() : Nat {
    teacher_id += 1;
    return teacher_id;
  };
  // public function to create a new Teacher
  public func new_teacher(first_name: Text, last_name: Text) : async Text {
    let new_teacher: Types.Teacher = {
      id = new_teacher_id();
      first_name = first_name;
      last_name = last_name;
    };
    teachers.put(Nat.toText(new_teacher.id), new_teacher);
    return "New teacher added whit ID: " # Nat.toText(new_teacher.id);
  };

  // public function to get a teacher by id
  public query func get_teacher(id: Nat) : async ?Types.Teacher {
    switch (teachers.get(Nat.toText(id))) {
      case (null) {
        Debug.print("Teacher not found");
        return null; };
      case (_teacher) { return teachers.get(Nat.toText(id)); };
    };
  };

  // public function to update a teacher by id
  public func update_teacher(id: Nat, first_name: Text, last_name: Text) : async Text {
    let teacher = teachers.get(Nat.toText(id));
    switch (teacher) {
      case (null) {
        return "Teacher not found";
      };
      case (?teacher) {
        let updated_teacher: Types.Teacher = {
          id = teacher.id;
          first_name = if (first_name == "") teacher.first_name else first_name;
          last_name = if (last_name == "") teacher.last_name else last_name;
        };
        teachers.put(Nat.toText(updated_teacher.id), updated_teacher);
        return "Teacher updated";
      };
    };
  };

  // public function to delete a teacher by id
  public func delete_teacher(id: Nat) : async Text {
    switch (teachers.get(Nat.toText(id))) {
      case (null) {
        Debug.print("Teacher not found");
        return "Teacher not found"; };
      case (_) {
        ignore teachers.remove(Nat.toText(id));
        return "Teacher deleted"; };
    };
  };

  // private function to generate a new course id
  private func next_course_id() : Nat {
    course_id += 1;
    return course_id;
  };

  // public function to create a new course
  public func new_course(name: Text, teacher_id: Nat, hours: Nat) : async Text {
    let teacher = teachers.get(Nat.toText(teacher_id));
    switch (teacher) {
      case (null) {
        return "Teacher not found";
      };
      case (?teacher) {
      let new_course: Types.Course = {
      id = next_course_id();
      name = name;
      teacher = teacher;
      hours = hours;
    };
    courses.put(Nat.toText(new_course.id), new_course);
    return "New course added whit ID: " # Nat.toText(new_course.id);
    }
    };
  };

  // public function to get a course by id
  public query func get_course(id: Nat) : async ?Types.Course {
    switch (courses.get(Nat.toText(id))) {
      case (null) {
        Debug.print("Course not found");
        return null; };
      case (_course) { return courses.get(Nat.toText(id)); };
    };
  };

  // public function to update a course by id
  public func update_course(id: Nat, name: Text, teacher_id: Nat, hours: Nat) : async Text {
    let course = courses.get(Nat.toText(id));
    switch (course) {
      case (null) {
        return "Course not found";
      };
      case (?course) {
        let teacher = teachers.get(Nat.toText(teacher_id));
        switch (teacher) {
          case (null) {
            return "Teacher not found";
          };
          case (?teacher) {
            let updated_course: Types.Course = {
              id = course.id;
              name = if (name == "") course.name else name;
              teacher = teacher;
              hours = if (hours == 0) course.hours else hours;
            };
            courses.put(Nat.toText(updated_course.id), updated_course);
            return "Course updated";
          };
        };
      };
    };
  };

  // public function to delete a course by id
  public func delete_course(id: Nat) : async Text {
    switch (courses.get(Nat.toText(id))) {
      case (null) {
        Debug.print("Course not found");
        return "Course not found"; };
      case (_) {
        ignore courses.remove(Nat.toText(id));
        return "Course deleted"; };
    };
  };

  // Test values
  public func test_values() : async Text {
    
    let _student1 = new_student("John", "Doe");
    let _student2 = await new_student("Jane", "Doe");
    let _student3 = await new_student("Alice", "Doe");
    let _student4 = await new_student("Bob", "Doe");
    let _teacher1 = await new_teacher("John", "Smith");
    let _teacher2 = await new_teacher("Jane", "Smith");
    let _teacher3 = await new_teacher("Alice", "Smith");
    let _course1 = await new_course("Math", 1, 40);
    let _course2 = await new_course("History", 2, 30);
    return "Test values added";
  };
};
