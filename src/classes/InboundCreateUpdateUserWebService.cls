/**************************************************************************************
Apex Class Name     : InboundCreateUpdateUserWebService 
Created Date        : 2/24/2016
Function            : This class is an inbound webservice to create user in Salesforce 
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------                 
*Vivek Singh               2/12/2016                 Added Method createUpdateUser
 *************************************************************************************/
@RestResource(urlMapping='/user_create_update_AEM/*')
global class InboundCreateUpdateUserWebService {
    
     /*
     * Method name  : createUpdateUser
     * Description  : This method is used to create/update/Deactivate user in Salesforce
     * Return Type  : String
     * Parameter    : List<userinfo> userinfo
     */
    
    @HttpPost
    global static String createUpdateUser(userinfo userinfo){
        String response;
        System.debug('request'+userinfo);
        try{
            if(userinfo.OperationMode.op.equalsIgnoreCase('Create')){
            String strAlias= String.valueOf(DateTime.now().getTime());
            User u= new User();
            u.FirstName=userinfo.ud.firstName;
            u.LastName=userinfo.ud.lastName;
            u.Email=userinfo.ud.email;
            u.Username=userinfo.ud.userId;
            u.Middle_Name__c=userinfo.ud.middleName;
            u.Maiden_Name__c=userinfo.ud.maidenName;
            u.Formatted_Name__c=userinfo.ud.formattedName;
            u.Phonetic_First_Name__c=userinfo.ud.phoneticFirstName;
            u.Phonetic_Last_Name__c=userinfo.ud.phoneticLastName;
            u.Gender__c=userinfo.ud.gender;
            u.ProfessionalId__c=userinfo.ud.professionalId;
            u.HeadLine__c=userinfo.ud.headLine;  
            u.Credentials__c=userinfo.ud.credentials;
            u.SpecialityDetails__c=userinfo.ud.specialityDetails;
            String tempHospital;
                if(userinfo.ud.hospitals!=null){
                  for(String hop:userinfo.ud.hospitals){
                 if(tempHospital==null) {
                     tempHospital=hop;
                 }else{
                   tempHospital=tempHospital+';'+hop; 
                 } 
                } 
                   u.Hospitals__c=tempHospital;
                }
            u.MedicalSchool__c=userinfo.ud.medicalSchool;
            u.Notification_Email__c=userinfo.ud.notificationemail;
            u.Social_Id__c=userinfo.ud.socialId;
            u.Industry__c=userinfo.ud.industry;
            u.LinkedInSpecialties__c=userinfo.ud.linkedInSpecialties;
            u.PictureUrl__c=userinfo.ud.pictureUrl;
            u.OriginalPictureUrl__c=userinfo.ud.originalPictureUrl;
            u.Verified__c=userinfo.ud.verified;  
            u.Npi__c=userinfo.ud.npi;
            u.Graduation_Year__c=userinfo.ud.graduationYear;  
            u.Practice_Type__c=userinfo.ud.practiceType;
            u.ValueAmount__c=userinfo.ud.valueAmount;   
            u.Profile_Completeness__c=userinfo.ud.profileCompleteness;
            u.ITG_Country__c=userinfo.ud.country;
            u.ITG_Region__c=userinfo.ud.region;
            u.Service_Provider__c=userinfo.ud.serviceProvider;
            u.User_Created__c=true;
            String tempspecialty;
                if(userinfo.ud.speciality!=null){
                  for(String spec:userinfo.ud.speciality){
                 if(tempspecialty==null) {
                     tempspecialty=spec;
                 }else{
                   tempspecialty=tempspecialty+';'+spec; 
                 } 
                } 
                   u.speciality__c=tempspecialty;
                }
               
            
            u.Primary_Language__c=userinfo.ud.primarylanguage;
            String tempInterest;
                if(userinfo.ud.interests!=null){
                  for(string intrst:userinfo.ud.interests){
                   if(tempInterest==null) {
                     tempInterest=intrst;
                 }else{
                   tempInterest=tempInterest+';'+intrst; 
                 }     
              } 
               u.Interests__c=tempInterest;
             }
           u.Newsletter_Flag__c=userinfo.ud.newsLetterFlag;
            u.Alias=strAlias.substring(strAlias.length()-8, strAlias.length()); 
            u.EmailEncodingKey='UTF-8';
            u.LanguageLocaleKey='en_US';
            u.LocaleSidKey='en_US';
            u.TimeZoneSidKey='America/Los_Angeles';
            u.ProfileId = GetProfile('HCP Chatter User').ID;
            insert u;
            if(userinfo.ud.primaryLocation!=null){
                UserUtilityClass.createPrimaryAddress(userinfo.ud,u.Id);
              }
              if(userinfo.ud.addtionalLocations!=null){
                 UserUtilityClass.createAdditionalAddress(userinfo.ud,u.Id);
              }
              if(userinfo.ud.positions!=null){
                 UserUtilityClass.createUserPosition(userinfo.ud,u.Id);
              }  
                
            System.setPassword(u.Id, userinfo.ud.password);
            response= 'User has been created in Salesforce with Id as ='+u.Id;
        } 
        if(userinfo.OperationMode.op.equalsIgnoreCase('Update')){
            User u=[Select id, userName,email from User where userName=: userinfo.ud.userId];
            if(userinfo.ud.firstName!=null){
              u.FirstName=userinfo.ud.firstName;  
            }
            if(userinfo.ud.lastName!=null){
             u.LastName=userinfo.ud.lastName; 
            }
            if(userinfo.ud.email!=null){
             u.Email=userinfo.ud.email;   
            }
            if(userinfo.ud.socialId!=null){
              u.Social_Id__c=userinfo.ud.socialId;
            }
            if(userinfo.ud.notificationEmail!=null){
               u.Notification_Email__c=userinfo.ud.notificationEmail;
            }
            if(userinfo.ud.userId!=null){
             u.Username=userinfo.ud.userId;   
            }
            if(userinfo.ud.middleName!=null){
               u.Middle_Name__c=userinfo.ud.middleName; 
            }
            if(userinfo.ud.maidenName!=null){
               u.Maiden_Name__c=userinfo.ud.maidenName; 
            }
            if(userinfo.ud.formattedName!=null){
               u.Formatted_Name__c=userinfo.ud.formattedName;
            }
            if(userinfo.ud.phoneticFirstName!=null){
               u.Phonetic_First_Name__c=userinfo.ud.phoneticFirstName;  
            }
            if(userinfo.ud.phoneticLastName!=null){
              u.Phonetic_Last_Name__c=userinfo.ud.phoneticLastName;  
            }
            if(userinfo.ud.gender!=null){
              u.Gender__c=userinfo.ud.gender;  
            }
            if(userinfo.ud.professionalId!=null){
             u.ProfessionalId__c=userinfo.ud.professionalId;    
            }
            if(userinfo.ud.headLine!=null){
              u.HeadLine__c=userinfo.ud.headLine; 
            }
            if(userinfo.ud.credentials!=null){
              u.Credentials__c=userinfo.ud.credentials; 
            }     
            if(userinfo.ud.specialityDetails!=null){
             u.SpecialityDetails__c=userinfo.ud.specialityDetails;   
            }
            if(userinfo.ud.hospitals!=null){
              String tempHospital;
                if(userinfo.ud.hospitals!=null){
                  for(String hop:userinfo.ud.hospitals){
                 if(tempHospital==null) {
                     tempHospital=hop;
                 }else{
                   tempHospital=tempHospital+';'+hop; 
                 } 
                } 
                   u.Hospitals__c=tempHospital;
                }  
            }
            if(userinfo.ud.medicalSchool!=null){
              u.MedicalSchool__c=userinfo.ud.medicalSchool;  
            }
            if(userinfo.ud.industry!=null){
              u.Industry__c=userinfo.ud.industry;  
            }
            if(userinfo.ud.linkedInSpecialties!=null){
               u.LinkedInSpecialties__c=userinfo.ud.linkedInSpecialties; 
            }
            if(userinfo.ud.pictureUrl!=null){
              u.PictureUrl__c=userinfo.ud.pictureUrl;  
            }
            if(userinfo.ud.originalPictureUrl!=null){
              u.OriginalPictureUrl__c=userinfo.ud.originalPictureUrl;
            }
            if(userinfo.ud.verified!=null){
              u.Verified__c=userinfo.ud.verified;  
            }
            if(userinfo.ud.npi!=null){
               u.Npi__c=userinfo.ud.npi; 
            }
            if(userinfo.ud.graduationYear!=null){
              u.Graduation_Year__c=userinfo.ud.graduationYear;  
            }
            if(userinfo.ud.practiceType!=null){
               u.Practice_Type__c=userinfo.ud.practiceType; 
            }
            
            if(userinfo.ud.valueAmount!=null){
             u.ValueAmount__c=userinfo.ud.valueAmount;   
            }
             if(userinfo.ud.profileCompleteness!=null){
                 u.Profile_Completeness__c=userinfo.ud.profileCompleteness;
              }
            if(userinfo.ud.userId!=null){
              u.Username=userinfo.ud.userId;  
            } 
            if(userinfo.ud.country!=null){
              u.ITG_Country__c=userinfo.ud.country;  
            }
            if(userinfo.ud.region!=null){
              u.ITG_Region__c=userinfo.ud.region;   
            }
            if(userinfo.ud.serviceProvider!=null){
             u.Service_Provider__c=userinfo.ud.serviceProvider;   
            }
             
            String tempspecialty;
            if(userinfo.ud.speciality!=null){
              for(String spec:userinfo.ud.speciality){
                 if(tempspecialty==null) {
                     tempspecialty=spec;
                 }else{
                   tempspecialty=tempspecialty+';'+spec; 
                 } 
                }
                u.speciality__c=tempspecialty;
            }
             
            if(userinfo.ud.primarylanguage!=null){
               u.Primary_Language__c=userinfo.ud.primarylanguage; 
            }
            String tempInterest;
            if(userinfo.ud.interests!=null){
              for(string intrst:userinfo.ud.interests){
                   if(tempInterest==null) {
                     tempInterest=intrst;
                 }else{
                   tempInterest=tempInterest+';'+intrst; 
                 }     
              } 
               u.Interests__c=tempInterest;
            }
             
            if(userinfo.ud.newsLetterFlag!=null){
                u.Newsletter_Flag__c=userinfo.ud.newsLetterFlag;
            }
             if(userinfo.ud.primaryLocation!=null){
                UserUtilityClass.createPrimaryAddress(userinfo.ud,u.Id);
              }
              if(userinfo.ud.addtionalLocations!=null){
                 UserUtilityClass.createAdditionalAddress(userinfo.ud,u.Id);
              }
              if(userinfo.ud.positions!=null){
                 UserUtilityClass.createUserPosition(userinfo.ud,u.Id);
              } 
            update u;
            if(userinfo.ud.password!=null){
                if(String.isNotBlank(userinfo.ud.password)){
                    System.setPassword(u.Id, userinfo.ud.password);
                }
                 
            }
           
          // ConnectApi.Photo photo= ConnectApi.UserProfiles.setPhoto('', u.Id,  new ConnectApi.BinaryInput(Blob.valueof(userinfo.ud.image),'image/jpg','userImage.jpg'));
            response='User has been updated successfully';           
        }
        if(userinfo.OperationMode.op=='Delete'){
            User u=[Select id, email,userName from User where id=: userinfo.ud.email];
            u.IsActive=false;
            update u;
            response='User has been de-activated successfully';
        } 
        }catch(Exception e){
           System.debug('e.getMessage()'+e.getMessage());
          response=e.getMessage();  
        }
       
        return response;
    }
     public static Profile GetProfile(String profileName) {
         Profile p = [SELECT Id FROM Profile WHERE Name =:profileName Limit 1];  
         return p;         
    } 
    
    
    global class cls_OperationMode {
        global string op;
    }  
    global class userinfo{
        global userDetails ud;
        global cls_OperationMode OperationMode;
    }
    global class userDetails{
        global String firstName;    //Test
        global String lastName; //Test
        global string middleName;
        global string maidenName;
        global string formattedName;
        global string phoneticFirstName;
        global string phoneticLastName;
        global string gender;
        global string professionalId;
        global string headLine;
        global String email;    //abc@xyz.com
        global String country;
        global String userId;
        global String profileCompleteness;
        global String region;
        global String newsLetterFlag;
        global List<String> speciality;
        global string serviceProvider;
        global string password;
        global List<String>interests;
        global string primarylanguage; 
        global primaryLocation primaryLocation;
        global list<addtionalLocations> addtionalLocations;
        global list<position> positions;
        global String credentials;
        global String specialityDetails;
        global List<String> hospitals;
        global String medicalSchool;
        global String industry;
        global String linkedInSpecialties;
        global String pictureUrl;
        global String originalPictureUrl;
        global String verified;
        global String npi;
        global String graduationYear;
        global String practiceType;
        global String valueAmount;
        global String imageUrl;
        global String notificationemail;
        global String socialId;
    }
    global class primaryLocation{
        global String phone;
        global String longitude;
        global String fax;
        global String latitude;
        global String countryCode;
        global String state;
        global String locationName;
        global String city;
        global String addressLine2;
        global String zip;
        global String addressLine1;
    }
    global class addtionalLocations{
        global String latitude;
        global String city;
        global String state;
        global String zip;
        global String countryCode;
        global String longitude;
        global String locationName;
        global String phone;
        global String addressLine2;
        global String fax;
        global String addressLine1;
    }
    global class position{
        global String id;
        global String endDate;
        global String startDate;
        global String isCurrent;
        global String summary;
        global company company;
        global String title;
    }
    global class company{
        global String id;
        global String industry;
        global String type;
        global String ticker;
        global String name;
    }
    

}