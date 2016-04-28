/**************************************************************************************
Apex Class Name     : InboudUpdateUserImageWebservice 
Created Date        : 2/24/2016
Function            : This class is an inbound webservice to send image url back to Salesforce
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------                 
*Vivek Singh               2/24/2016                 readpic
 *************************************************************************************/
    @RestResource(urlMapping='/user_read_Image/*')
global class InboudReadUserImageWebservice {
  @HttpPost
    global static String readpic(String userId){
        ConnectApi.Photo ph;
         List<User> userlist= [Select id, userName from user where userName=:userId];
        if(!userlist.isEmpty()){
           ph = ConnectApi.UserProfiles.getPhoto(null, userlist[0].Id);
            
        }
        return ph.fullEmailPhotoUrl;
    }
}