use axum::{
    extract::ws::{Message, WebSocket, WebSocketUpgrade},
    response::IntoResponse,
    routing::get,
    Router,
};
use serde::{Deserialize, Serialize};
use sqlx::PgPool;
use std::sync::Arc;
use tower_http::services::ServeDir;

mod vm;
use vm::VirtualMachine;

#[derive(Serialize, Deserialize)]
struct VmCmd {
    cmd: String,
    pid: Option<u32>,
}

#[tokio::main]
async fn main() {
    tracing_subscriber::init();

    let pool = PgPool::connect("postgres://admin:secret@localhost:5432/blackboxos")
        .await
        .unwrap();

    let vm = Arc::new(VirtualMachine::new(pool.clone()));

    let app = Router::new()
        .route("/ws", get(ws_handler))
        .nest_service("/static", ServeDir::new("static"))
        .layer(Arc::clone(&amp;vm).into_layer());  // Custom layer stub

    let listener = tokio::net::TcpListener::bind("0.0.0.0:8080").await.unwrap();
    tracing::debug!("VM server listening on 8080");
    axum::serve(listener, app).await.unwrap();
}

async fn ws_handler(
    ws: WebSocketUpgrade,
    vm_arc: Arc<VirtualMachine>,
) -> impl IntoResponse {
    ws.on_upgrade(move |socket| handle_socket(socket, vm_arc))
}

async fn handle_socket(mut socket: WebSocket, vm: Arc<VirtualMachine>) {
    while let Some(Ok(msg)) = socket.recv().await {
        if let Message::Text(text) = msg {
            let cmd: VmCmd = serde_json::from_str(&amp;text).unwrap_or_default();
            let result = vm.execute(&amp;cmd.cmd).await.unwrap_or("Error".to_string());
            let out = serde_json::to_string(&amp;result).unwrap();
            if socket.send(Message::Text(out)).await.is_err() {
                break;
            }
        }
    }
}

