package blackbox;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.client.standard.StandardWebSocketClient;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import java.util.concurrent.Future;

public class BlackBoxApp extends TextWebSocketHandler {
    private static final String VM_WS = "ws://rust-vm:8080/ws";

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        System.out.println("Java App: " + message.getPayload());
        // Echo to VM
        session.sendMessage(new TextMessage("Java exec: " + message.getPayload()));
    }

    public static void main(String[] args) {
        var client = new StandardWebSocketClient();
        var handler = new BlackBoxApp();
        Future<Void> future = client.doHandshake(handler, VM_WS);
        // Run app sim
        System.out.println("Java BlackBoxApp launched, connected to VM.");
    }
}

