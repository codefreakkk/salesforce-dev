public class StudentHandler implements IStudentHandler {
	
    List<Student> studentList = new List<Student>();
    
    public void addStudent(Student student) {	
        studentList.add(student);
        System.debug('Student Added');
    }
    
    public Student getStudentByEmail(String email) {
        for (Student student : studentList) {
            if (student.getStudentEmail().equals(email)) {
                return student;
            }
        }
        return null;
    }
    
    public void getAllStudent() {
        for (Student student : studentList) {
            System.debug('Name = ' + student.getStudentName() + ' Email = ' + student.getStudentEmail() + ' Age = ' + student.getAge());
        }
    }
    
    public void updateStudent(String name, String email, Integer age, String emailId) {
        for (Student student : studentList) {
            if (student.getStudentEmail().equals(emailId)) {
                student.setStudentName(name);
                student.setStudentEmail(email);
                student.setStudentAge(age);
                break;
            }
        }
        System.debug('Student Updated');
    }
}