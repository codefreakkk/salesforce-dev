public class Student {
	private String name, email;
    private Integer age;
    
    public Student(String name, String email, Integer age) {
        this.name = name;
        this.email = email;
        this.age = age;
    }
    
    public void setStudentName(String name) {
        this.name = name;
    }
    
    public void setStudentEmail(String email) {
        this.email = email;
    }
    
    public void setStudentAge(Integer age) {
        this.age = age;
    }
    
    public String getStudentName() {
        return name;
    }
    
    public String getStudentEmail() {
        return email;
    }
    
    public Integer getAge() {
        return age;
    }
}