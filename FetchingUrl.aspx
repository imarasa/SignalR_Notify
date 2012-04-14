<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FetchingUrl.aspx.cs" Inherits="FetchingUrl" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Magic-Dev :: Fetching URL Detail - Demo</title>
    <script src="Scripts/jquery-1.6.4.min.js" type="text/javascript"></script>
    <style type="text/css">
    .content{margin: 20px auto; width:512px; }
    #txtUrl{width:500px; padding:5px; border:solid 1px #ccc; font:10pt verdana;}
    #urlDesc{width:500px; padding:5px; overflow:hidden; border:solid 1px #ccc; background:#fcfcfc; display:none;}
    .detail{width:390px; float:right;}
    #urlTitle{ font:bold 10pt verdana; color:#555; padding:5px 5px 0 5px;}
    #urlContent{font:10pt verdana; color:#888; padding:2px 5px 5px 5px;}
    #urlLink{font:8pt verdana; color:#888; padding:5px;}
    #urlImg{float:left; margin:5px; width:100px;}
    </style>
    <script type="text/jscript">
        $(document).ready(function () {
            $('#txtUrl').keyup(function () {
                if ($("#txtUrl").val().indexOf("http://") >= 0) {
                    clear();
                    $('#urlDesc').show();
                    $('#urlTitle').html("Loading...");

                    $.ajax({ type: "POST",
                        url: "WebService.asmx/getUrlDesc",
                        data: "{str:'" + $("#txtUrl").val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {

                            var result = response.d;
                            if (result.pageTitle != "") {
                                $('#urlDesc').show();
                                $('#urlTitle').html(result.pageTitle);
                                $('#urlContent').html(result.pageContent);
                                $('#urlLink').html(result.pageLink);

                                $('#urlImg').show();
                                $('#urlImg').attr("src", result.pageImg);
                                $('#urlImg').error(function () {
                                    $(this).hide();
                                });
                            }
                            else {
                                clear();
                            }

                        },
                        error: function (msg) {
                            clear();
                        }

                    });
                }
                else {
                    $('#urlTitle').html("");
                    $('#urlContent').html("");
                    $('#urlDesc').hide();
                }
            });

            function clear() {
                $('#urlTitle').html("");
                $('#urlContent').html("");
                $('#urlLink').html("");
                $('#urlDesc').hide();
                $('#urlImg').attr("src", "");
                $('#urlImg').hide();
            }
            //            $("#txtUrl").bind("paste", function () {
            //                // $('#urlDesc').show();
            //                $('#txtUrl').keyup();
            //            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="content">
        <input id="txtUrl" type="text" />
        <div id="urlDesc">
            <img id="urlImg" src="" alt="" />
            <div class="detail">
                <div id="urlTitle">
                </div>
                <div id="urlLink">
                </div>
                <div id="urlContent">
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
