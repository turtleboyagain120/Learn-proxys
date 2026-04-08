-- Seed initial data for BlackBoxOS VM

-- Default user
INSERT INTO users (username, password_hash) VALUES ('guest', 'sha256_hash_here') ON CONFLICT DO NOTHING;

-- Virtual FS: /bin apps
INSERT INTO files (path, content, owner_id, is_dir) VALUES 
('/bin/calc', decode('print("Calculator: 2+2=4\\n")', 'escape'), 1, false),
('/bin/ai', decode('ai_assist("Hello VM!")', 'escape'), 1, false),
('/etc/config.yml', decode('theme: holographic\\nusers: 1', 'escape'), 1, false)
ON CONFLICT (path) DO NOTHING;

-- Example process
INSERT INTO processes (vm_id, name, pid, status) VALUES (1, 'init', 1, 'running') ON CONFLICT DO NOTHING;

