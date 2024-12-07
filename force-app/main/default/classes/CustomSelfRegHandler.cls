public without sharing class CustomSelfRegHandler {

    @AuraEnabled
    public static String selfRegister(String firstName, String lastName, String email, String studentName, String password) {

        
        try {
            
        Contact contact = new Contact(FirstName = firstName, LastName = lastName);
        insert contact;

        // Create User record
        User newUser = new User();
        newUser.FirstName = firstName;
        newUser.LastName = lastName;
        newUser.Email = email;
        newUser.Username = email; // Ensure username is unique
        newUser.Alias = firstName.substring(0, 1) + lastName.substring(0, 1);
        newUser.TimeZoneSidKey = 'America/Los_Angeles';
        newUser.LocaleSidKey = 'en_US';
        newUser.EmailEncodingKey = 'UTF-8';
        newUser.LanguageLocaleKey = 'en_US';
        newUser.ContactId = contact.Id;
        newUser.ProfileId = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus User' LIMIT 1].Id;
 
        // Insert User record
        insert newUser;
        System.debug('User created for experience cloud');

        // set password
        System.setPassword(newUser.Id, password);
 
        // Create Student record
        Student__c newStudent = new Student__c();
        newStudent.Student_Name__c = studentName;
        newStudent.Student_Email__c = email;
        newStudent.Linked_User__c = newUser.Id; // Link User to Student
        insert newStudent;
        System.debug('Student created for experience cloud');
 
        return 'Registration successful';
        } catch (Exception e) {
            return 'error' + e.getMessage();
        }
    }
}