@isTest(seeALLData=true)
public class Test_InboundImageWebservice {
    public static testmethod void testImageWebservice(){
        Test.startTest();
        List<User>userList=[Select id ,username from User];
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/user_create_update_Image/'+userList[0].userName;
        req.httpMethod = 'post';
        //req.requestBody=Blob.valueOf('iVBORwhwoecwnouwc');
        RestContext.request = req;
        InboudUpdateUserImageWebservice.attachPic();
        InboudReadUserImageWebservice.readpic(userList[0].userName);
        Test.stopTest();
    }
}