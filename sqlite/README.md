### TSV to SQLITE DB

This is a script to save the tsv files into sqlite database. The main use-case is to use Sqlite MCP tool so that the agent can query the database without loading all data into memory. The script assumes that you have zsh installed to run it.

- install MCP for sqlite
  - `npm install -g mcp-sqlite-tools`
- install sql utils to translate tsv to sqlitedb
  - `brew install sqlite-utils`
- clone the data from this repo:
  - https://github.com/itbench-hub/ITBench-Snapshots
- run the script one directory above the cloned repo using `database` directory as the location of sqlite tables
  - `./tsv-to-sqlite.zsh ./database/`
- check the created files using zsh glob syntax for recursive subdirectories traversal
  - `ls ./database/**/*.db`
    - `./database/Scenario-1/default.db`
    - `./database/Scenario-102/default.db`
