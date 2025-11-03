# Minimalist SRE-Agent Playground with MCP Tools

## Prerequisites

To use the SRE-Agent playground, you need the following installed or running in your OS:

- access to a Kubernetes cluster with `KUBECONFIG` environment variable pointing to the cluster's kubeconfig file.
  ```bash
  # add in your .bashrc/.bash_profile or .zshrc/.zshenv
  export KUBECONFIG=/path/to/kubeconfig_file
  ```
- `uv` command
  ```bash
    # For Linux and MacOS
    curl -LsSf https://astral.sh/uv/install.sh | sh
  ```
- `kubectl` command
  ```bash
    # For Linux
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    # For MacOS
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/arm64/kubectl"
  ```
- `helm` command
  ```bash
    curl -sSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
  ```
- `node` command

  ```bash
  # For MacOS
  # using brew
  brew install node

  # For Linux/MacOS
  # using curl
  # Download and install nvm:
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  # restart the shell
  nvm install 25
  ```

- `ollama` server for serving local agents

  ```bash
  # install ollama in linux
  curl -fsSL https://ollama.com/install.sh | sh

  # install ollama using brew in MacOS
  brew install ollama
  # or download the ollama application
  curl -OL "https://ollama.com/download/Ollama.dmg"
  ```

- `qwen3:8b` local llm running in ollama server

  ```bash
  # install qwen3 chatbot
  ollama pull qwen3:8b
  ollama list
  # test the chatbot
  ollama run qwen3:8b
  ```

- `Flowise` GUI framework for Agentflow or Chatflow
  ```bash
  # install flowise
  npm install -g flowise
  # start flowise and access it at http://localhost:3000
  npx flowise start
  ```

## Flowise Framework for AI Applications

There are three major options to build AI-powered applications in `Flowise`, namely: `Assistants`, `Chatflows`, and `Agentflows`.
An AI Assistant provides the simplest way to build AI applications using preconfigured structure for rapid prototyping. It lacks
customization but it can be a good choice to try and explore a running application in the flowise framework.

Chatflow focuses on a single agent doing tasks using different sources of information while Agentflow covers advanced features
for multi-steps reasoning, multi-agents interaction, decision-making, planning, orchestration, and context engineering.
Since Agentflow is a superset of Chatflow and provides the most customization among the three,
its framework will be used in the implementation of `Simple Agent` and `Supervisor-Workers` Agents and their
customizations and configurations will be explained below.

### Simple Agent Mode

- #### Start flowise if it is not running: `npx flowise start`
- #### Open flowise in a browser at `http://localhost:3000`
- #### Navigate at the left-hand menu and click `Agentflows` to open the main panel and click the `Add New` button located at the upper right corner.

<img src="/images/agentflow.png" alt="agentflow" width="500">

- #### Click the plus button to open the available tools. Drag-and-drop the `Agent` component.

<img src="/images/agent.png" alt="agent" width="500">

- #### Connect the `start` component to the `Agent` component

<img src="/images/start-agent.png" alt="start" width="500">

- #### Double-click the `Agent` component to open the custimization options. In the `Model` section, search for ChatOllama.

<img src="/images/ollama-server.png" alt="ollama" width="500">

- #### Click the `ChatOllama Parameters` drop-down menu. The Base URL is already correct. Add `qwen3:8b` in the `Model Name`. Leave the other options in their default values.

<img src="/images/qwen3.png" alt="qwen3" width="500">

- #### Goto the `Tools` section. Search for the keyword `MCP` and choose `Custom MCP`.

<img src="/images/mcp.png" alt="mcp" width="500">

- #### Click the `Custom MCP Parameters` menu. Copy and paste the following json configuration:

  ```
  {
    "command": "uvx",
    "args": [
        "--from",
        "git+https://github.com/mdwoicke/kuber-mcp-server.git",
        "kubectl-mcp"
    ],
    "env": {
        "KUBECONFIG": "/absolute/path/to/.kube/config"
  }
  ```

  <img src="/images/mcp-config.png" alt="mcpconfig" width="500">

- #### Click the refresh tools and select the actions from the drop-down menu.

<img src="/images/refresh-choose-tools.png" alt="refresh" width="500">

- #### As you choose the actions in the list, the tool list will be updated.

<img src="/images/tools-listing.png" alt="actions" width="500">

- #### Finally, look for the `Messages` section and add a system prompt.

  <img src="/images/add-system-prompt.png" alt="prompt" width="500">

- #### You can close the `Agent` customization options by clicking anywhere outside the customization box. At the upper-right corner, click the chat icon to open the chat interface as shown below.

  <img src="/images/chat1.png" alt="chatbutton" width="100">
  <img src="/images/chat2.png" alt="chatinterface" width="100">

  **_NOTE:_** One can skip the manual creation of this simple SRE agent by loading the json file called `simple-sre-agent.json` in the **agents** directory. 
Navigate at the left-hand menu and click `Agentflows` to open the main panel and click the `Add New` button located at the upper right corner. 
Once the `Agentflow` panel is active, click the gear icon at the upper right corner and choose `Load Agents`. Clone the repo so that you have the 
copy of the json file that you can load. Just remember to edit the `Custom MCP Parameters` of the agent with the following content:
```
{
  "command": "uvx",
  "args": [
      "--from",
      "git+https://github.com/mdwoicke/kuber-mcp-server.git",
      "kubectl-mcp"
  ],
  "env": {
      "KUBECONFIG": "/absolute/path/to/.kube/config"
}
```
