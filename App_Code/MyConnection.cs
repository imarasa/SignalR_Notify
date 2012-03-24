using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading.Tasks;
using SignalR;
using SignalR.Hubs;

/// <summary>
/// Summary description for MyConnection
/// </summary>
public class MyConnection : PersistentConnection
{
    protected override Task OnReceivedAsync(string connectionId, string data)
    {
        // Broadcast data to all clients
        return Connection.Broadcast(data);
    }

}
