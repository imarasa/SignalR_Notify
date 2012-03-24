<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="Scripts/jquery-1.6.4.min.js" type="text/javascript"></script>
    <script src="Scripts/jquery.signalR.min.js" type="text/javascript"></script>
    <style type="text/css">
    #Notifications{position:fixed; z-index:10; bottom:20px; left:100px; width:250px; overflow:hidden;}
    #Notifications .notify {margin:10px; border:solid 1px #999; background:#FFFFD5; display:none;}
    #Notifications .notify .text{padding:10px; font:10pt tahoma; color:#333;}
    #Notifications .notify .btnClose{float:right;padding: 1px;margin:3px; width:10px; text-align:center;
                  border:solid 1px #777; background:#ccc; font:bold 7pt Arial; color:#555; cursor:pointer;}
    #Notifications .notify .btnClose:hover{background:#555; color:#ccc}
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <script type="text/javascript">
            $(function () {
                // Proxy created on the fly
                var connection = $.connection('echo');

                connection.received(function (data) {
                    var closebtn = "<div class=\"btnClose\">X</div>";
                    var text = "<div class=\"text\">" + data + "</div>";
                    $('#Notifications').append('<div class=\"notify\">' + closebtn + text + '</div>');
                    $(".notify").show(200);
                });
                connection.start();
                $('.btnClose').live("click", function (e) {
                    $(this).parent().remove();
                });
            });

        </script>
        <ul id="messages">
        </ul>

        <div id="Notifications">
        </div>
    </div>
    </form>
</body>
</html>