/**************************************************************************************
Apex Class Name     : InboundFetchUserWebservice 
Created Date        : 2/24/2016
Function            : This class is an inbound webservice to read user details in Salesforce 
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------                 
*Vivek Singh               2/12/2016                 Added Method readUserDetails
 *************************************************************************************/
@RestResource(urlMapping='/user_read_AEM/*')
global class InboundFetchUserWebservice {
    @HttpPost
    global static userDetails readUserDetails(String userId){
        List<User> userList= [Select firstName, userName,fullphotourl,Notification_Email__c,Social_Id__c,lastName,Middle_Name__c,Maiden_Name__c,Formatted_Name__c,Phonetic_First_Name__c,Phonetic_Last_Name__c,Gender__c,ProfessionalId__c,HeadLine__c,Credentials__c,SpecialityDetails__c,Hospitals__c,MedicalSchool__c,Industry__c,LinkedInSpecialties__c,PictureUrl__c,OriginalPictureUrl__c,Verified__c,Npi__c,Graduation_Year__c,Practice_Type__c,ValueAmount__c,email,country,ITG_Country__c,ITG_Region__c,Primary_Language__c,Profile_Completeness__c,Newsletter_Flag__c,Service_Provider__c,Speciality__c,Interests__c from User where userName=:userId];
        userDetails ud= new userDetails();    
        if(!userList.isEmpty()){ 
                ud.firstName=userList[0].firstName;
                ud.lastName=userList[0].lastName;
                ud.middleName=userList[0].Middle_Name__c;
                ud.maidenName=userList[0].Maiden_Name__c;
                ud.formattedName=userList[0].Formatted_Name__c;
                ud.phoneticFirstName=userList[0].Phonetic_First_Name__c;
                ud.phoneticLastName=userList[0].Phonetic_Last_Name__c;
                ud.gender=userList[0].Gender__c;
                ud.professionalId=userList[0].ProfessionalId__c;
                ud.headLine=userList[0].HeadLine__c;
                ud.credentials=userList[0].Credentials__c;
                ud.specialityDetails=userList[0].SpecialityDetails__c;
                 if(userlist[0].Hospitals__c!=null){
                    ud.hospitals=userlist[0].Hospitals__c.split('\\;');
                }
                ud.medicalSchool=userList[0].MedicalSchool__c;
                ud.industry=userList[0].Industry__c;
                ud.linkedInSpecialties=userList[0].LinkedInSpecialties__c;
                ud.pictureUrl=userList[0].PictureUrl__c;
                ud.originalPictureUrl=userList[0].OriginalPictureUrl__c;
                ud.verified=userList[0].Verified__c;
                ud.npi=userList[0].Npi__c;
                ud.graduationYear=userList[0].Graduation_Year__c;
                ud.practiceType=userList[0].Practice_Type__c;
                ud.valueAmount=userList[0].ValueAmount__c;
                ud.email=userlist[0].email;
                ud.country=userlist[0].ITG_Country__c;
                ud.region=userlist[0].ITG_Region__c;
                ud.imageURl=userlist[0].fullphotourl;
                ud.socialid=userlist[0].Social_Id__c;
                ud.notificationemail=userlist[0].Notification_Email__c;
                ud.newsLetterFlag=String.valueof(userlist[0].Newsletter_Flag__c);
                if(userlist[0].Speciality__c!=null){
                    ud.speciality=userlist[0].Speciality__c.split('\\;');
                }
                ud.serviceProvider=userlist[0].Service_Provider__c;
                if(userlist[0].Interests__c!=null){
                    ud.interests=userlist[0].Interests__c.split('\\;');
                }
                ud.userId=userlist[0].userName;
                ud.primarylanguage=userlist[0].Primary_Language__c;
                ud.profileCompleteness=String.valueof(userlist[0].Profile_Completeness__c);
            
        List<User_Address__c> userAddressList=[Select id,Name, AddressLine1__c,AddressLine2__c,City__c,CountryCode__c,Fax__c,Latitude__c,LocationName__c,Longitude__c,Phone__c,State__c,User__c	,Zip__c,Recordtype.DeveloperName from User_Address__c where user__c=:userList[0].Id];
            if(!userAddressList.isEmpty()){
            List<addtionalLocations>listAdditonalLocations= new List<addtionalLocations>();
            for(User_Address__c uad: userAddressList){
                if(uad.RecordType.DeveloperName=='Primary_Location'){
                    primaryLocation p= new primaryLocation();
                    p.addressLine1=uad.AddressLine1__c;
                    p.addressLine2=uad.AddressLine2__c;
                    p.locationName=uad.LocationName__c;
                    p.countryCode=uad.CountryCode__c;
                    p.state=uad.State__c;
                    p.city=uad.City__c;
                    p.zip=uad.Zip__c;
                    p.latitude=uad.Latitude__c;
                    p.longitude=uad.Longitude__c;
                    p.phone=uad.Phone__c;
                    p.fax=uad.Fax__c;
                    ud.primaryLocation=p;
                }else if(uad.RecordType.DeveloperName=='Additional_Location'){
                    addtionalLocations p = new addtionalLocations();
                    p.addressLine1=uad.AddressLine1__c;
                    p.addressLine2=uad.AddressLine2__c;
                    p.locationName=uad.LocationName__c;
                    p.countryCode=uad.CountryCode__c;
                    p.state=uad.State__c;
                    p.city=uad.City__c;
                    p.zip=uad.Zip__c;
                    p.latitude=uad.Latitude__c;
                    p.longitude=uad.Longitude__c;
                    p.phone=uad.Phone__c;
                    p.fax=uad.Fax__c;
                    listAdditonalLocations.add(p);
                }
        }  
        ud.addtionalLocations=listAdditonalLocations;
        }else {
            ud.primaryLocation=null;
            ud.addtionalLocations=null;
        }  
           List<User_Position__c>userPosList=[Select id,Company_Id__c,Company_Ticker__c,Company_Type__c,Company_Name__c,Company_Industry__c,IsCurrent__c,Name,Position_Summary__c,Position_Id__c,Position_Start_Date__c,Position_End_Date__c from User_Position__c where user__c=:userList[0].Id];
            if(!userPosList.isEmpty()){
                List<position>posList= new List<position>();
                for(User_Position__c up:userPosList){
                    position p= new position();
                    p.id=up.Position_Id__c;
                    p.title=up.Name;
                    p.summary=up.Position_Summary__c;
                    p.startDate=up.Position_Start_Date__c;
                    p.endDate=up.Position_End_Date__c;
                    p.isCurrent=up.IsCurrent__c;
                    company c= new company();
                    c.Id=up.Company_Id__c;
                    c.name=up.Company_Name__c;
                    c.type=up.Company_Type__c;
                    c.industry=up.Company_Industry__c;
                    c.ticker=up.Company_Ticker__c;
                    p.company=c;
                    posList.add(p);
                }
                ud.positions=posList;
            }else {
                ud.positions=null;
            }
       }
         return ud;
    }

     global class userDetails{
        global String firstName;	//Test
  		global String lastName;	//Test
  		global String email;	//abc@xyz.com
        global String country;
        global String region;
        global String newsLetterFlag;
        global String [] speciality;
        global string serviceProvider;       
        global string userId;
        global string [] interests;
        global string primarylanguage;
        global String profileCompleteness;
        global String imageURl;
        global string middleName;
        global string maidenName;
        global string formattedName;
        global string phoneticFirstName;
        global string phoneticLastName;
        global string gender;
        global string professionalId;
        global string headLine;
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