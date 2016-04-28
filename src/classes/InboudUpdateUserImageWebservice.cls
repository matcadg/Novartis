/**************************************************************************************
Apex Class Name     : InboudUpdateUserImageWebservice 
Created Date        : 2/24/2016
Function            : This class is an inbound webservice to update image for user
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------                 
*Vivek Singh               2/24/2016                 Added Method attachPic
 *************************************************************************************/
@RestResource(urlMapping='/user_create_update_Image/*')
global class InboudUpdateUserImageWebservice {
   @HttpPost
    global static void attachPic(){
     RestRequest req = RestContext.request;
    RestResponse res = RestContext.response;
      String userName = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
       List<User> userlist= [Select id, userName from user where userName=:userName];
        if(!userlist.isEmpty()){
            Blob pic = req.requestBody;
            if(!Test.isRunningTest())
            ConnectApi.Photo photo= ConnectApi.UserProfiles.setPhoto(null, userlist[0].Id,  new ConnectApi.BinaryInput(pic,'image/jpg','userImage.jpg'));
        }

    }
}