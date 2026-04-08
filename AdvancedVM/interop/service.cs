using System;
using System.Text.Json;
using System.Net.WebSockets;
using Microsoft.Extensions.Hosting;

public class InteropService
{
    private ClientWebSocket ws = new();

    public async Task<string> ExecInterop(string jsonPayload)
    {
        // Connect to Rust VM
        await ws.ConnectAsync(new Uri("ws://rust-vm:8080/ws"), CancellationToken.None);
        var cmd = JsonSerializer.Deserialize<JsonElement>(jsonPayload);
        var bytes = JsonSerializer.SerializeToUtf8Bytes(cmd);
        await ws.SendAsync(new ArraySegment<byte>(bytes), WebSocketMessageType.Text, true, CancellationToken.None);
        var buffer = new byte[1024];
        var result = await ws.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);
        return System.Text.Encoding.UTF8.GetString(buffer, 0, result.Count);
    }
}

// Host stub
class Program
{
    static async Task Main() { 
        var service = new InteropService();
        Console.WriteLine(await service.ExecInterop("{\"cmd\": \"ps\"}"));
    }
}

