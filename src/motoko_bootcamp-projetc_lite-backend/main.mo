import Types "./types";
import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
actor {
  
  let students = HashMap.HashMap<Text, Types.Student>(0, Text.equal, Text.hash);

  // convert to stable memory when implement [mops - map]
  var student_id : Nat = 0;
  // private function to generate a new student id
  private func next_student_id() : Nat {
    student_id += 1;
    return student_id;
  };

  // public function to create a new student
  public func new_student(first_name: Text, last_name: Text) : async Text {
    let new_student: Types.Student = {
      id = next_student_id();
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
};
