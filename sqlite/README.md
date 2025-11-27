### TSV to SQLITE DB

This is a script to save the tsv files into sqlite database. The main use-case is to use Sqlite MCP tool so that the agent can query the database without loading all data into memory. The script assumes that you have zsh installed.

- install MCP for sqlite
  - `npm install -g mcp-sqlite-tools`
- install sql utils to translate tsv to sqlitedb
  - `brew install sqlite-utils`
- clone the data from this repo:
  - https://github.com/itbench-hub/ITBench-Snapshots
- run the script below one directory above the cloned repo assuming you want to use the `database` directory as the location of sqlite tables
  - `./tsv-to-sqlite.zsh ./database/`
- check the created files using zsh syntax for recursive subdirectories search
  - `ls ./database/**/*.db`
    - `./database/Scenario-1/default.db`
    - `./database/Scenario-102/default.db`
