@RestResource(urlMapping='/user_validate_AEM/*')
global class InboundValidateUserWebService {
    @HttpPost
    global static Boolean validateUser(String email, String userName){
        Boolean flag=false;
         if(email !=null){
            List<User> userList= [Select firstName, userName,lastName,email,country,ITG_Country__c,ITG_Region__c,Newsletter_Flag__c,Service_Provider__c from User where Email=:email];
            if(!userList.isEmpty()){
                flag=true;
            }
        }else if(userName!=null){
             List<User> userListUserName= [Select firstName, lastName,email,country,ITG_Country__c,ITG_Region__c,Newsletter_Flag__c,Service_Provider__c from User where userName=:userName];   
                if(!userListUserName.isEmpty()){
                flag=true;
            }
            }
        
        return flag;
    }

}