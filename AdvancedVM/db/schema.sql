-- BlackBoxOS Virtual Filesystem and Processes (SQL Schema)

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS files (
    id SERIAL PRIMARY KEY,
    path VARCHAR(1024) UNIQUE NOT NULL,
    content BYTEA,
    owner_id INTEGER REFERENCES users(id),
    is_dir BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS processes (
    id SERIAL PRIMARY KEY,
    vm_id INTEGER,  -- Links to VM instance
    name VARCHAR(100),
    pid INTEGER UNIQUE NOT NULL,
    status VARCHAR(20) CHECK (status IN ('running', 'stopped', 'zombie')),
    memory_usage BIGINT DEFAULT 0,
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for perf
CREATE INDEX idx_files_path ON files(path);
CREATE INDEX idx_processes_pid ON processes(pid);
CREATE INDEX idx_processes_status ON processes(status);

-- Trigger: Auto-update modified time (simplified)
CREATE OR REPLACE FUNCTION update_modified() RETURNS TRIGGER AS $$
BEGIN
   NEW.created_at = CURRENT_TIMESTAMP;
   RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER files_update BEFORE UPDATE ON files FOR EACH ROW EXECUTE FUNCTION update_modified();

