use serde::{Deserialize, Serialize};
use sqlx::{PgPool, Row};
use std::collections::HashMap;
use std::sync::{Arc, Mutex};

#[derive(Serialize)]
pub struct VmState {
    pub processes: Vec<String>,
    pub memory: String,  // Hex dump stub
}

pub struct VirtualMachine {
    pool: PgPool,
    state: Arc<Mutex<HashMap<u32, String>>>,  // Sim mem
}

impl VirtualMachine {
    pub fn new(pool: PgPool) -> Self {
        Self {
            pool,
            state: Arc::new(Mutex::new(HashMap::new())),
        }
    }

    pub async fn execute(&amp;self, cmd: &amp;str) -> Result<String, sqlx::Error> {
        match cmd {
            "ls" => {
                let rows = sqlx::query("SELECT path FROM files WHERE is_dir = false LIMIT 5")
                    .fetch_all(&amp;self.pool).await?;
                let paths: Vec<_> = rows.iter().map(|r| r.get::<String, _>("path")).collect();
                Ok(format!("Files: {:?}", paths))
            }
            "ps" => {
                let rows = sqlx::query("SELECT name, status FROM processes LIMIT 5")
                    .fetch_all(&amp;self.pool).await?;
                let procs: Vec<_> = rows.iter().map(|r| format!("{} ({})", r.get::<String, _>("name"), r.get::<String, _>("status"))).collect();
                Ok(format!("Processes: {:?}", procs))
            }
            _ => Ok(format!("VM Exec: {} (stub)", cmd)),
        }
    }

    pub fn state(&amp;self) -> VmState {
        VmState {
            processes: vec!["init".to_string()],
            memory: "DEADBEEF".to_string(),
        }
    }
}

