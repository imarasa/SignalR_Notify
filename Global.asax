<%@ Application Language="C#" %>

<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="SignalR.Hosting.AspNet.Routing" %>

<script runat="server">



    void Application_Start(object sender, EventArgs e) 
    {
        RouteTable.Routes.MapConnection<MyConnection>("echo", "echo/{*operation}");
    }
    
    void Application_End(object sender, EventArgs e) 
    {
    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
    }

    void Session_Start(object sender, EventArgs e) 
    {
    }

    void Session_End(object sender, EventArgs e) 
    {

    }
       
</script>
