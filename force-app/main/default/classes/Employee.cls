public class Employee implements IEmployee {
    private String name, email;
    
    public Employee(String name) {
        this.name = name;
    }
    
    public Employee(String name, String email) {
		this.name = name;
        this.email = email;
    }
    
    public String getEmployeeName() {
        return this.name;
    }
    
    public String getEmployeeEmail() {
        return this.email;
    }
}