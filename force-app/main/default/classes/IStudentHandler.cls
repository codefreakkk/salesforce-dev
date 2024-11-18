public interface IStudentHandler {
	void addStudent(Student student);
    Student getStudentByEmail(String email);
    void getAllStudent();
    void updateStudent(String name, String email, Integer age, String emailId);
}