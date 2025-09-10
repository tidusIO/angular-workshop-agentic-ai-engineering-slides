---
layout: cover
---

# Workshop Task

## Building an Angular Migration MCP Tool

<div class="grid grid-cols-2 gap-8 mt-8">

<div>

### Your Mission

Add a migration tool to your MCP server that can execute Angular migrations from [angular.dev/update-guide](https://angular.dev/update-guide)

</div>

<div>

<img src="https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=500&h=300&fit=crop" alt="Migration task" class="rounded-lg shadow-lg" />

</div>

</div>

---
layout: default
---

# Task Overview

## What You Need to Implement

<div class="space-y-6">

### **Objective**

Create a new MCP tool called `run_migration` that:

- Accepts Angular version as input
- Executes `ng update` commands
- Provides clear feedback on migration progress
- Handles errors gracefully

### **Expected Behavior**

When you ask your AI assistant:

> "Run the migration to Angular 18"

The AI should:

1. Call your MCP tool
2. Execute the migration command
3. Show you the results

</div>

<div class="mt-8 p-4 bg-blue-100 dark:bg-blue-900 rounded-lg">

**Goal**: Make AI assistants capable of running Angular migrations directly.

</div>

---
layout: default
---

# Implementation Steps

## Step-by-Step Guide

<div class="space-y-6">

### **1. Add Migration Tool Registration**

```typescript
server.registerTool(
  "run_migration",
  {
    title: "Run Angular Migration",
    description: "Execute Angular update migrations",
    inputSchema: {
      version: z.string().describe('Target Angular version (e.g., "18.0.0")'),
      packages: z
        .array(z.string())
        .optional()
        .describe("Specific packages to update"),
    },
  },
  async ({ version, packages }) => {
    // Your implementation here
  },
);
```

### **2. Implement Migration Logic**

```typescript
async ({ version, packages }) => {
  try {
    // Construct migration command
    const command = packages
      ? `npx @angular/cli update ${packages.join(" ")}@${version}`
      : `npx @angular/cli update @angular/core@${version}`;

    // Execute command
    const result = await exec(command, {
      cwd: dirname(dirname(__dirname)),
    });

    return {
      content: [
        {
          type: "text",
          text: `✅ Migration completed successfully:\n${result.stdout}`,
        },
      ],
    };
  } catch (error) {
    return {
      content: [
        {
          type: "text",
          text: `❌ Migration failed: ${error.message}`,
        },
      ],
    };
  }
};
```

</div>

---
layout: default
---

# Advanced Features

## Enhance Your Migration Tool

<div class="space-y-6">

### **1. Pre-Migration Validation**

```typescript
async function validateMigration(version: string): Promise<boolean> {
  try {
    // Check if Angular CLI is available
    await exec("npx @angular/cli version", {
      cwd: dirname(dirname(__dirname)),
    });

    // Check current Angular version
    const packageJson = await readPackageJson();
    const currentVersion = packageJson.dependencies["@angular/core"];

    // Validate version compatibility
    return isVersionCompatible(currentVersion, version);
  } catch (error) {
    return false;
  }
}
```

### **2. Migration Progress Tracking**

```typescript
async ({ version, packages }) => {
  const steps = [
    "Validating current setup...",
    "Checking compatibility...",
    "Running migration...",
    "Verifying results...",
  ];

  let progress = "";
  for (const step of steps) {
    progress += `\n🔄 ${step}`;
    // Execute step logic
  }

  return {
    content: [
      {
        type: "text",
        text: `Migration Progress:${progress}\n\n✅ Migration completed!`,
      },
    ],
  };
};
```

</div>

---
layout: default
---

# Testing Your Implementation

## Verify Everything Works

<div class="space-y-6">

### **1. Build and Test**

```bash
# Build your MCP server
npm run build.angular-mcp

# Test the migration tool
node dist/angular-mcp/index.js
```

### **2. Integration Test**

1. **Reload your AI assistant** (Cursor, Copilot, etc.)
2. **Ask for a migration**:
   ```
   "Run the migration to Angular 18"
   ```
3. **Verify the behavior**:
   - AI calls your MCP tool
   - Migration command executes
   - You see the results

### **3. Error Testing**

Try invalid scenarios:

- Non-existent Angular version
- Invalid package names
- Network connectivity issues

</div>

<div class="mt-8 p-4 bg-yellow-100 dark:bg-yellow-900 rounded-lg">

**Important**: Test with a safe Angular version first (like a patch update) before trying major version migrations.

</div>

---
layout: default
---

# Bonus Challenges

## Extend Your Implementation

<div class="grid grid-cols-2 gap-8">

<div>

### **Challenge 1: Multi-Package Migration**

```typescript
// Support updating multiple packages at once
{
  version: "18.0.0",
  packages: ["@angular/core", "@angular/cli", "@angular/material"]
}
```

### **Challenge 2: Migration History**

```typescript
// Track and display migration history
server.registerResource("migration_history", {
  // Implementation
});
```

</div>

<div>

### **Challenge 3: Rollback Support**

```typescript
// Add ability to rollback migrations
server.registerTool("rollback_migration", {
  // Implementation
});
```

### **Challenge 4: Migration Preview**

```typescript
// Show what will change before running
server.registerTool("preview_migration", {
  // Implementation
});
```

</div>

</div>

---
layout: default
---

# Success Criteria

## How to Know You're Done

<div class="space-y-4">

### **✅ Basic Requirements**

- [ ] Migration tool is registered
- [ ] Accepts version parameter
- [ ] Executes `ng update` command
- [ ] Returns success/error messages
- [ ] Handles errors gracefully

### **✅ Integration Test**

- [ ] AI assistant can call the tool
- [ ] Migration commands execute correctly
- [ ] Results are displayed properly
- [ ] Error cases are handled

### **✅ Advanced Features** (Optional)

- [ ] Pre-migration validation
- [ ] Progress tracking
- [ ] Multi-package support
- [ ] Migration history

</div>

<div class="mt-8 p-4 bg-green-100 dark:bg-green-900 rounded-lg">

**You're ready when you can ask your AI assistant to run Angular migrations and it actually works!**

</div>

---
layout: default
---

# Resources and Help

## Where to Get Support

<div class="space-y-4">

### **Documentation**

- [Angular Update Guide](https://angular.dev/update-guide)
- [MCP TypeScript SDK](https://github.com/modelcontextprotocol/typescript-sdk)
- [Angular CLI Commands](https://angular.io/cli)

### **Common Issues**

- **Permission errors**: Check file system permissions
- **Command not found**: Ensure Angular CLI is installed
- **Version conflicts**: Verify package compatibility
- **Network issues**: Check internet connectivity

### **Debugging Tips**

- Add console.log statements
- Test commands manually first
- Check MCP server logs
- Verify file paths

</div>

---
layout: center
---

# Ready to Start?

## Your Angular Migration MCP Tool Awaits

<div class="mt-8 text-2xl">

**Time to build**: 30-45 minutes

</div>

<div class="mt-4 text-lg">

**Difficulty**: Intermediate

</div>

<div class="mt-8">

<carbon:play class="inline-block w-8 h-8" />

</div>
