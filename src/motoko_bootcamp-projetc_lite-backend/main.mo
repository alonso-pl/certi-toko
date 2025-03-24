import Types "./types";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Array "mo:base/Array";
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
        //Delete all enrollments from this student
        let _ = await delete_enrollment_by_student_id(id);
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
        //Delete all enrollments from this course
        let _ = await delete_enrollment_by_course_id(id);
        ignore courses.remove(Nat.toText(id));
        return "Course deleted"; };
    };
  };

  // public function to create a new enrollment
  public func new_enrollment(student_id: Nat, course_id: Nat, status: Text) : async Text {
    let student = students.get(Nat.toText(student_id));
    let course = courses.get(Nat.toText(course_id));
    switch (student) {
      case (null) {
        return "Student not found";
      };
      case (?student) {
        switch (course) {
          case (null) {
            return "Course not found";
          };
          case (?course) {
            let new_enrollment: Types.Enrollment = {
              student = student;
              course = course;
              status = status;
            };
            enrollments.put(Nat.toText(student.id) # "-" # Nat.toText(course.id), new_enrollment);
            return "New enrollment added";
          };
        };
      };
    };
  };

  //public function to update a status enrollment by student_id and course_name
  public func update_enrollment(student_id: Nat, course_id: Nat, status: Text) : async Text {
    let enrollment = enrollments.get(Nat.toText(student_id) # "-" # Nat.toText(course_id));
    switch (enrollment) {
      case (null) {
        return "Enrollment not found";
      };
      case (?enrollment) {
        let updated_enrollment: Types.Enrollment = {
          student = enrollment.student;
          course = enrollment.course;
          status = status;
        };
        enrollments.put(Nat.toText(enrollment.student.id) # "-" # Nat.toText(enrollment.course.id), updated_enrollment);
        return "Enrollment updated";
      };
    };
  };
  
  // public function to get a all courses by student id
  public query func get_courses_by_student_id(student_id: Nat) : async [Types.Course] {
    let student = students.get(Nat.toText(student_id));
    switch (student) {
      case (null) {
        Debug.print("Student not found");
        return [];
      };
      case (?student) {
        let student_enrollments = enrollments.vals();
        var student_courses: [Types.Course] = [];
        for (enrollment in student_enrollments) {
          if (enrollment.student.id == student.id) {
            student_courses := Array.append(student_courses, [enrollment.course]);
          };
        };
        return student_courses;
      };
    };
  };

  // public function to get a all students by course id
  public query func get_students_by_course_id(course_id: Nat) : async [Types.Student] {
    let course = courses.get(Nat.toText(course_id));
    switch (course) {
      case (null) {
        Debug.print("Course not found");
        return [];
      };
      case (?course) {
        let course_enrollments = enrollments.vals();
        var course_students: [Types.Student] = [];
        for (enrollment in course_enrollments) {
          if (enrollment.course.id == course.id) {
            course_students := Array.append(course_students, [enrollment.student]);
          };
        };
        return course_students;
      };
    };
  };

  // public function to delete a all enrollment by student_id
  public func delete_enrollment_by_student_id(student_id: Nat) : async Text {
    let student = students.get(Nat.toText(student_id));
    switch (student) {
      case (null) {
        return "Student not found";
      };
      case (?student) {
        let student_enrollments = enrollments.vals();
        for (enrollment in student_enrollments) {
          if (enrollment.student.id == student.id) {
            ignore enrollments.remove(Nat.toText(enrollment.student.id) # "-" # Nat.toText(enrollment.course.id));
          };
        };
        return "All enrollments from " # student.first_name # " " # student.last_name # "deleted";
      };
    };
  };

  // public function to delete a all enrollment by course_id
  public func delete_enrollment_by_course_id(course_id: Nat) : async Text {
    let course = courses.get(Nat.toText(course_id));
    switch (course) {
      case (null) {
        return "Course not found";
      };
      case (?course) {
        let course_enrollments = enrollments.vals();
        for (enrollment in course_enrollments) {
          if (enrollment.course.id == course.id) {
            ignore enrollments.remove(Nat.toText(enrollment.student.id) # "-" # Nat.toText(enrollment.course.id));
          };
        };
        return "All enrollments from " # course.name # "deleted";
      };
    };
  };

  // public function to create a new certificate id
  private func new_certificate_id() : Nat {
    certificate_id += 1;
    return certificate_id;
  };

  //public function to create a new certificate
  public func new_certificate(student_id: Nat, course_id: Nat, date: Types.Date) : async Text {
    let student = students.get(Nat.toText(student_id));
    let course = courses.get(Nat.toText(course_id));
    switch (student) {
      case (null) {
        return "Student not found";
      };
      case (?student) {
        switch (course) {
          case (null) {
            return "Course not found";
          };
          case (?course) {
            let new_certificate: Types.Certificate = {
              id = new_certificate_id();
              student = student;
              course = course;
              date = date;
            };
            certificates.put(Nat.toText(new_certificate.id), new_certificate);
            return "New certificate added";
          };
        };
      };
    };
  };

    // public function to get a certificate by id
  public query func get_certificate(id: Nat) : async ?Types.Certificate {
    switch (certificates.get(Nat.toText(id))) {
      case (null) {
        Debug.print("Certificate not found");
        return null; };
      case (_certificate) { return certificates.get(Nat.toText(id)); };
    };
  };

  // public function to update certificate by id
  public func update_certificate(id: Nat, student_id: Nat, course_id: Nat, date: Types.Date) : async Text {
    let certificate = certificates.get(Nat.toText(id));
    switch (certificate) {
      case (null) {
        return "Certificate not found";
      };
      case (?certificate) {
        let student = students.get(Nat.toText(student_id));
        switch (student) {
          case (null) {
            return "Student not found";
          };
          case (?student) {
            let course = courses.get(Nat.toText(course_id));
            switch (course) {
              case (null) {
                return "Course not found";
              };
              case (?course) {
                let updated_certificate: Types.Certificate = {
                  id = certificate.id;
                  student = student;
                  course = course;
                  date = date;
                };
                certificates.put(Nat.toText(updated_certificate.id), updated_certificate);
                return "Certificate updated";
              };
            };
          };
        };
      };
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
    let _course3 = await new_course("Science", 3, 50);
    let _enrollet1 = await new_enrollment(1, 1, "active");
    let _enrollet2 = await new_enrollment(2, 1, "Not Approved");
    let _enrollet3 = await new_enrollment(3, 1, "Approved");
    let _enrollet4 = await new_enrollment(1, 2, "active");
    let _enrollet5 = await new_enrollment(2, 2, "Approved");
    let _enrollet6 = await new_enrollment(3, 2, "Approved");
    let _enrollet7 = await new_enrollment(3, 3, "active");
    let _certificate1 = await new_certificate(1, 1, {year = 2021; month = 10; day = 10});
    let _certificate2 = await new_certificate(2, 1, {year = 2021; month = 10; day = 10});

    return "Test values added";
  };
};
