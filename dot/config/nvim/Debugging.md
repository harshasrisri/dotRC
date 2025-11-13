# Debugging

This configuration includes comprehensive debugging support using nvim-dap with language-specific debuggers.

**Prerequisites:**
- `delve`(Golang) and `codelldb`(C/C++/Rust) via `Mason`
- `debugpy`(Python) via `uv`, `pip`, `pacman`, `brew`, etc.

## C/C++

This configuration provides three debugging modes:

### 1. Launch (Basic)
For debugging single programs directly:
- Open a C/C++ source file
- Set breakpoints with `<leader>db`
- Press `<leader>dc` → Select "Launch"
- Enter path to your compiled executable
- Enter arguments if needed

### 2. Launch with Child Process Debugging
For debugging launcher programs that spawn child processes (e.g., launcher → multi-threaded service):
- Open source file from the child/launchee program
- Set breakpoints in the child process code
- Press `<leader>dc` → Select "Launch with Child Process Debugging"
- Enter path to the **launcher** executable
- Enter launcher arguments
- The debugger will follow into the spawned child process and stop at your breakpoints

This uses:
- `follow-fork-mode child` - Follows child processes when they fork/exec
- `detach-on-fork false` - Keeps debugger attached through process creation

### 3. Attach to Process
For attaching to an already-running program:
- Start your program manually
- Find the process ID: `ps aux | grep your_program`
- Open relevant source file
- Set breakpoints with `<leader>db`
- Press `<leader>dc` → Select "Attach to Process"
- Enter the PID when prompted

## Rust
1. **Basic Debugging:**
   - Open a Rust source file
   - Set breakpoints with `<leader>db`
   - Press `<leader>dc` → Select "Launch"
   - Enter executable path: `target/debug/your_program`
   - Enter CLI arguments if needed

2. **With Arguments:**
   - When prompted "Arguments:", enter space-separated arguments
   - Example: `--config config.toml --verbose input.txt`

# Troubleshooting

## Debugger doesn't start
- Verify codelldb is installed: `ls ~/.local/share/nvim/mason/bin/codelldb`
- If missing, install via Mason: `:MasonInstall codelldb`
- For Python: Check debugpy is installed: `python -c "import debugpy"`
- For Go: Check delve is installed: `which dlv`

## Breakpoints not hit
- Ensure your program is compiled with debug symbols (`-g` flag for C/C++, no `--release` for Rust)
- Verify the executable path matches the source code
- For child processes, use "Launch with Child Process Debugging" configuration
