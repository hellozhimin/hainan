<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%!
    //string :posterfilelist,defaultPath:图片不存在是给的默认图片路径,request：JSP默认对象,posttype:获取的海报位置 1普通海报 2缩略图 3剧照 
	public String getColumnPosterPath(String posterfilelist,String defaultPath,HttpServletRequest request,int posttype)
	{
	    String picPath = defaultPath;
	    if( posterfilelist==null ||posterfilelist.equals("")) return picPath;
	    String path = request.getContextPath();
        String imgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String[] picPathList=posterfilelist.split(";");
		if(picPathList !=null){
		    if(posttype==1 && picPathList.length>=1){
		       picPath = imgPath+"images/columnposter/" + picPathList[0];
		       return picPath;
		    }
		    if(posttype==2 && picPathList.length>=2){
		       picPath = imgPath+"images/columnposter/" + picPathList[1];
		       return picPath;
		    }
		    if(posttype==3 && picPathList.length>=3){
		        picPath = imgPath+"images/columnposter/" + picPathList[2];
		        return picPath;
		    }
		}
		return picPath;
    }
    
	//string :posterfilelist,defaultPath:图片不存在是给的默认图片路径,request：JSP默认对象,posttype:获取的海报位置 1普通海报 2缩略图 3剧照 
	public String getPosterPath(String posterfilelist,String defaultPath,HttpServletRequest request,int posttype)
	{
	    String picPath = defaultPath;
	    if( posterfilelist==null ||posterfilelist.equals("")) return picPath;
	    String path = request.getContextPath();
        String imgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String[] picPathList=posterfilelist.split(";");
		if(picPathList !=null){
		    if(posttype==1 && picPathList.length>=1){
		       picPath = imgPath+"images/poster/" + picPathList[0];
		       return picPath;
		    }
		    if(posttype==2 && picPathList.length>=2){
		       picPath = imgPath+"images/poster/" + picPathList[1];
		       return picPath;
		    }
		    if(posttype==3 && picPathList.length>=3){
		        picPath = imgPath+"images/poster/" + picPathList[2];
		        return picPath;
		    }
		}
		return picPath;
    }

	//string :posterfile,request：JSP默认对象
	public String getPosterPath(String posterfile,HttpServletRequest request)
	{
	    String path = request.getContextPath();
        String imgPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		String picPath = "";
		if(posterfile !=null){
		     picPath = imgPath+"images/poster/" + posterfile;
		}
		return picPath;
    }
%>


