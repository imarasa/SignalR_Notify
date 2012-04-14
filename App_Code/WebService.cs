using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using HtmlAgilityPack;


public class pageDesc
{
    public string pageTitle = "";
    public string pageContent = "";
    public string pageLink = "";
    public string pageImg = "";
}
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
[System.Web.Script.Services.GenerateScriptType(typeof(pageDesc))]

public class WebService : System.Web.Services.WebService
{

    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }
    [WebMethod]
    public pageDesc getUrlDesc(string str)
    {
        pageDesc pgDesc = new pageDesc();
        str = str.Trim();
        if (str.Trim() == "")
            return null;
        string url = "";
        if (str.Contains("http://"))
        {
            url = str.Substring(str.IndexOf("http://"));
            if (url.Contains(" "))
                url = url.Substring(0, url.IndexOf(' '));

            if (IsAbsoluteUrl(url))
            {
                System.Net.WebClient wc = new System.Net.WebClient();
                HtmlDocument doc = new HtmlDocument();
                doc.Load(wc.OpenRead(url), true);

                var metaTags = doc.DocumentNode.SelectNodes("//title");
                if (metaTags != null)
                    pgDesc.pageTitle = metaTags[0].InnerText;
                metaTags = doc.DocumentNode.SelectNodes("//meta");
                foreach (var tag in metaTags)
                {
                    if (tag.Attributes["name"] != null && tag.Attributes["name"].Value == "description")
                    {
                        pgDesc.pageContent = tag.Attributes["content"].Value;
                    }
                }

                metaTags = doc.DocumentNode.SelectNodes("//img");
                if (metaTags != null)
                {
                    pgDesc.pageImg = metaTags[0].Attributes["src"].Value;
                    if (!metaTags[0].Attributes["src"].Value.Contains("http://"))
                    {
                        if (metaTags[0].Attributes["src"].Value.IndexOf("/") == 0)
                            pgDesc.pageImg = "http://" + new Uri(url).Host + metaTags[0].Attributes["src"].Value;
                        else
                            pgDesc.pageImg = "http://" + new Uri(url).Host + "/" + metaTags[0].Attributes["src"].Value;
                    }
                }
                else
                    pgDesc.pageImg = "";
                pgDesc.pageLink = url;

                return pgDesc;
            }
            else
                return pgDesc;
        }
        else
            return null;
    }


    bool IsAbsoluteUrl(string url)
    {
        Uri result;
        return Uri.TryCreate(url, UriKind.Absolute, out result);
    }


}
