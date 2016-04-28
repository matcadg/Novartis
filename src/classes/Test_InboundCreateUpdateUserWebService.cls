@isTest
public class Test_InboundCreateUpdateUserWebService {
    public static testMethod void testinboundService(){
        Test.startTest();
         User u = new User(Alias = 'testUser', Email= 'abc@xyde.com', 
              EmailEncodingKey='UTF-8', LastName= 'lstName', LanguageLocaleKey='en_US', 
              LocaleSidKey='en_US', ProfileId = GetProfile('System Administrator').ID, 
              TimeZoneSidKey='America/Los_Angeles', UserName='abc@xyde.com');
        u.Interests__c='abc;yze';
        u.Speciality__c='ade;dew';
        u.Primary_Language__c='English';
        u.Profile_Completeness__c='20';
        insert u;
        InboundCreateUpdateUserWebService inb= new InboundCreateUpdateUserWebService();
        InboundCreateUpdateUserWebService.cls_OperationMode Oper= new InboundCreateUpdateUserWebService.cls_OperationMode();
        Oper.op='Create';
        //test for create user
        InboundCreateUpdateUserWebService.userinfo us= new InboundCreateUpdateUserWebService.userinfo();
        InboundCreateUpdateUserWebService.userDetails userdet= new InboundCreateUpdateUserWebService.userDetails();
        InboundCreateUpdateUserWebService.primaryLocation primaryloc= new InboundCreateUpdateUserWebService.primaryLocation();
        primaryloc.phone='3333';
        InboundCreateUpdateUserWebService.addtionalLocations additonalloc= new InboundCreateUpdateUserWebService.addtionalLocations ();
        additonalloc.phone='282';
        List<InboundCreateUpdateUserWebService.addtionalLocations>listadditionalLoc= new List<InboundCreateUpdateUserWebService.addtionalLocations>();
        listadditionalLoc.add(additonalloc);
        InboundCreateUpdateUserWebService.position pos= new InboundCreateUpdateUserWebService.position();
        pos.title='abc';
        InboundCreateUpdateUserWebService.Company poscompany= new InboundCreateUpdateUserWebService.Company();
        poscompany.name='test';
        pos.company=poscompany;
        List<InboundCreateUpdateUserWebService.position>positonList= new List<InboundCreateUpdateUserWebService.position>();
        positonList.add(pos);
        userdet.positions=positonList;
        userdet.addtionalLocations=listadditionalLoc;
        userdet.primaryLocation=primaryloc;
        userdet.firstName='aceg@xyzom'+System.now();
        userdet.lastName='ade'+System.now();
        userdet.email='xob'+'@xy.com';
        userdet.userId='xob'+'@xy.com';
        //creating speciality data
        List<String> specialityDta= new List<String>();
        specialityDta.add('test');
        userdet.speciality=specialityDta;
        userdet.interests=specialityDta;
        userdet.hospitals=specialityDta;
        userdet.profileCompleteness=String.valueof(20.0);
        userdet.newsLetterFlag=String.valueof(true);
        us.ud=userdet;
        us.OperationMode=Oper;
        
        InboundCreateUpdateUserWebService.createUpdateUser(us);
        //test for update user
        Oper.op='Update';
        us.OperationMode=Oper;
        userdet.middleName='ac';
        userdet.maidenName='test';
        userdet.formattedName='test';
        userdet.phoneticFirstName='test';
        userdet.phoneticLastName='test';
        userdet.gender='male';
        userdet.professionalId='id';
        userdet.headLine='test';
        userdet.credentials='test';
        userdet.specialityDetails='test';
        userdet.medicalSchool='test';
        userdet.industry='industry';
        userdet.linkedInSpecialties='linkedInSpecialties';
        userdet.pictureUrl='pictureUrl';
        userdet.originalPictureUrl='originalPictureUrl';
        userdet.verified='verified';
        userdet.npi='npi';
        userdet.graduationYear='graduationYear';
        userdet.practiceType='practiceType';
        userdet.valueAmount='valueAmount';
        us.ud=userdet;
        InboundCreateUpdateUserWebService.createUpdateUser(us);
        Oper.op='Delete';
        us.OperationMode=Oper;
        InboundCreateUpdateUserWebService.createUpdateUser(us);
        RecordType rdPrimary=[Select id, DeveloperName from RecordType where DeveloperName='Primary_Location' Limit 1];
        User_Address__c ud = new User_Address__c();
        ud.AddressLine1__c='test';
        ud.RecordTypeId=rdPrimary.Id;
        ud.User__c=u.Id;
        insert ud;
        RecordType rdAdditionalLoc=[Select id, DeveloperName from RecordType where DeveloperName='Additional_Location' Limit 1];
        User_Address__c udadditional = new User_Address__c();
        udadditional.AddressLine1__c='test';
        udadditional.RecordTypeId=rdAdditionalLoc.Id;
        udadditional.User__c=u.Id;
        insert udadditional;
        User_Position__c up = new User_Position__c();
        up.Name='Test';
        up.User__c=u.Id;
        insert up;
   
        InboundFetchUserWebservice.readUserDetails('abc@xyde.com');
        InboundValidateUserWebService.validateUser('abc@xyde.com',null);
        InboundValidateUserWebService.validateUser(null,'abc@xyde.com');
       	Test.stopTest();
    }
     public static Profile GetProfile(String profileName) {
         Profile p = [SELECT Id FROM Profile WHERE Name =:profileName Limit 1];  
         return p;         
    }
    
}