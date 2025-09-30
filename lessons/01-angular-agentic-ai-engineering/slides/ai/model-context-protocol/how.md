---
layout: cover
---

# How to Build an MCP Server

## Step-by-Step Implementation

<div class="grid grid-cols-2 gap-8 mt-8">

<div>

### What We'll Build

- Angular CLI integration
- Component generation tool
- Error handling
- TypeScript implementation

</div>

<div>

<img src="https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=500&h=300&fit=crop" alt="Building process" class="rounded-lg shadow-lg" />

</div>

</div>

---
layout: default
---

# Project Setup

## Initialize Your MCP Server

<div class="space-y-6">

### **1. Install Dependencies**

```bash
npm install @modelcontextprotocol/sdk zod
npm install --save-dev @types/node
```

### **2. Add Build Script**

```json
{
  "scripts": {
    "build.angular-mcp": "tsc --project tools/angular-mcp/tsconfig.json"
  }
}
```

### **3. Create Directory Structure**

```
tools/
└── angular-mcp/
    ├── index.ts
    └── tsconfig.json
```

</div>

<div class="mt-8 p-4 bg-blue-100 dark:bg-blue-900 rounded-lg">

**The TypeScript SDK provides everything you need to build MCP servers.**

</div>

---
layout: default
---

# TypeScript Configuration

## Set Up Compilation

<div class="space-y-4">

### **Create `tools/angular-mcp/tsconfig.json`**

```json
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "outDir": "../../dist/angular-mcp",
    "rootDir": ".",
    "esModuleInterop": true,
    "forceConsistentCasingInFileNames": true,
    "strict": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "types": ["node"]
  },
  "include": ["index.ts"],
  "exclude": ["node_modules", "dist"]
}
```

</div>

<div class="mt-8 p-4 bg-green-100 dark:bg-green-900 rounded-lg">

**This configuration ensures your MCP server compiles correctly for Node.js environments.**

</div>

---
layout: default
---

# Basic MCP Server Structure

## Foundation Implementation

<div class="space-y-4">

### **Import Required Modules**

```typescript
import { McpServer } from "@modelcontextprotocol/sdk/server/mcp.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";
import { exec as execSync } from "child_process";
import { dirname } from "path";
import { promisify } from "util";
import { z } from "zod";

const exec = promisify(execSync);
```

### **Initialize Server**

```typescript
const server = new McpServer({
  name: "workshops-de-angular-mcp",
  version: "1.0.0",
});
```

</div>

<div class="mt-8 p-4 bg-yellow-100 dark:bg-yellow-900 rounded-lg">

**The server name and version help AI assistants identify your MCP server.**

</div>

---
layout: default
---

# Register Your First Tool

## Component Generation Tool

<div class="space-y-4">

### **Tool Registration**

```typescript
server.registerTool(
  "generate_component",
  {
    title: "Generate Angular Component",
    description: "Creates a new Angular component using the Angular CLI",
    inputSchema: {
      name: z.string().describe("Component name"),
      path: z.string().optional().describe("Target path or project"),
    },
  },
  async ({ name, path }: { name: string; path?: string }) => {
    // Tool implementation
  },
);
```

</div>

<div class="mt-8 p-4 bg-purple-100 dark:bg-purple-900 rounded-lg">

**The inputSchema uses Zod for type-safe parameter validation.**

</div>

---
layout: default
---

# Implement Tool Logic

## Angular CLI Integration

<div class="space-y-4">

### **Command Construction**

```typescript
async ({ name, path }: { name: string; path?: string }) => {
  // Remove src/app prefix if present
  path = path?.replace(/^src\/app\/?/, "");

  // Construct CLI command
  const target = path ? `${path}/${name}` : name;
  const cliCommand = `npx @angular/cli generate component ${target} --standalone --flat --skip-tests --inline-style --inline-template --no-interactive`;

  // Execute command
  const result = await exec(cliCommand, {
    cwd: dirname(dirname(__dirname)),
  });

  return {
    content: [
      {
        type: "text",
        text: `✅ Component generated successfully:\n${result.stdout}`,
      },
    ],
  };
};
```

</div>

<div class="mt-8 p-4 bg-blue-100 dark:bg-blue-900 rounded-lg">

**The cwd parameter ensures commands run from the project root, not the MCP server directory.**

</div>

---
layout: default
---

# Error Handling

## Graceful Failure Management

<div class="space-y-4">

### **Try-Catch Implementation**

```typescript
try {
  const result = await exec(cliCommand, {
    cwd: dirname(dirname(__dirname)),
  });
  return {
    content: [
      {
        type: "text",
        text: `✅ Component generated successfully:\n${result.stdout}`,
      },
    ],
  };
} catch (error: unknown) {
  return {
    content: [
      {
        type: "text",
        text: `❌ CLI Error: ${error instanceof Error ? error.message : "Unknown error"}`,
      },
    ],
  };
}
```

</div>

<div class="mt-8 p-4 bg-red-100 dark:bg-red-900 rounded-lg">

**Always handle errors gracefully - AI assistants need clear feedback about what went wrong.**

</div>

---
layout: default
---

# Start the Server

## Connect and Listen

<div class="space-y-4">

### **Transport Setup**

```typescript
const transport = new StdioServerTransport();

server
  .connect(transport)
  .then(() => {
    console.log("MCP server started");
  })
  .catch((error) => {
    console.error("Error connecting to MCP server:", error);
  });
```

### **Complete Server File**

```typescript
// All previous code combined
// Save as tools/angular-mcp/index.ts
```

</div>

<div class="mt-8 p-4 bg-green-100 dark:bg-green-900 rounded-lg">

**The server is now ready to receive requests from AI assistants via standard input/output.**

</div>

---
layout: default
---

# Build and Test

## Compile Your MCP Server

<div class="space-y-6">

### **1. Build the Server**

```bash
npm run build.angular-mcp
```

### **2. Verify Output**

```
dist/angular-mcp/
└── index.js
```

### **3. Test Manually**

```bash
node dist/angular-mcp/index.js
```

</div>

<div class="mt-8 p-4 bg-yellow-100 dark:bg-yellow-900 rounded-lg">

**The compiled JavaScript file is what AI assistants will actually execute.**

</div>

---
layout: default
---

# AI Assistant Integration

## Connect to Cursor IDE

<div class="space-y-4">

### **1. Create MCP Configuration**

Create or edit `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "workshops-de-angular-mcp": {
      "command": "node",
      "args": ["/path/to/your/project/dist/angular-mcp/index.js"],
      "cwd": "/path/to/your/project"
    }
  }
}
```

### **2. Reload Cursor**

- Open Command Palette (`Cmd+Shift+P`)
- Run "Developer: Reload Window"

</div>

<div class="mt-8 p-4 bg-blue-100 dark:bg-blue-900 rounded-lg">

**Replace `/path/to/your/project` with your actual project path.**

</div>

---
layout: default
---

# Test Your Integration

## Verify Everything Works

<div class="space-y-6">

### **1. Ask AI to Generate Component**

```
"Generate a component called user-profile in the src/app/components directory"
```

### **2. Expected Behavior**

- AI makes MCP tool call
- Your server executes Angular CLI
- Component files are created
- AI shows success message

### **3. Troubleshooting**

- Check MCP server logs
- Verify file paths
- Ensure Angular CLI is available
- Check permissions

</div>

<div class="mt-8 p-4 bg-green-100 dark:bg-green-900 rounded-lg">

**Success! Your AI assistant can now generate Angular components directly.**

</div>

---
layout: center
---

# Congratulations!

## You've Built Your First MCP Server

<div class="mt-8 text-2xl">

**Next**: Explore advanced features and extensions

</div>

<div class="mt-4">

<carbon:arrow-right class="inline-block w-8 h-8" />

</div>
