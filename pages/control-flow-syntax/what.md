---
layout: default
transition: slide-left
---

# Core Concepts: Modern Control Flow

<div class="mt-8 p-6 bg-gradient-to-r from-blue-50 to-purple-50 dark:from-blue-900/20 dark:to-purple-900/20 rounded-xl">
  <h2 class="text-2xl font-bold mb-12 text-center">Three Essential Control Flow Blocks</h2>
  <div class="grid grid-cols-3 gap-4">
    <div class="text-center">
      <div class="text-4xl mb-2">@if</div>
      <p class="text-sm">Conditional rendering</p>
    </div>
    <div class="text-center">
      <div class="text-4xl mb-2">@for</div>
      <p class="text-sm">List iteration</p>
    </div>
    <div class="text-center">
      <div class="text-4xl mb-2">@switch</div>
      <p class="text-sm">Multiple conditions</p>
    </div>
  </div>
</div>

---
layout: default
---

# @if - Conditional Rendering

::left::

**Old Syntax (\*ngIf)**

```html {1-3|5-7|9-11}{lineNumbers:true}
<!-- Simple condition -->
<div *ngIf="isVisible">Content</div>

<!-- With else -->
<div *ngIf="condition; else other">Primary content</div>
<ng-template #other> Alternative content </ng-template>
```

::right::

**New Syntax (@if)**

```html {1-3|5-9}{lineNumbers:true}
<!-- Simple condition -->
@if (isVisible) {
<div>Content</div>
}

<!-- With else -->
@if (condition) {
<div>Primary content</div>
} @else {
<div>Alternative content</div>
}
```

---

## layout: default

# @if - Multiple Branches

```html {1-7|9-17}{lineNumbers:true,maxHeight:'350px'}
<!-- Old: Complex nested conditions -->
<div *ngIf="status === 'loading'">Loading...</div>
<div *ngIf="status === 'error'">Error occurred</div>
<div *ngIf="status === 'success'">
  <div *ngIf="data">{{ data }}</div>
  <div *ngIf="!data">No data</div>
</div>

<!-- New: Clear control flow -->
@if (status === 'loading') {
<div>Loading...</div>
} @else if (status === 'error') {
<div>Error occurred</div>
} @else if (status === 'success' && data) {
<div>{{ data }}</div>
} @else {
<div>No data</div>
}
```

<div class="mt-6 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
  <p class="text-blue-800 dark:text-blue-200">
    <strong>Benefit:</strong> @else if chains eliminate complex nesting
  </p>
</div>

---

## layout: default

# @for - List Iteration

::left::

**Old Syntax (\*ngFor)**

```html {lineNumbers:true}
<div *ngFor="let item of items">{{ item.name }}</div>

<!-- With trackBy -->
<div
  *ngFor="let item of items;
             trackBy: trackById"
>
  {{ item.name }}
</div>
```

::right::

**New Syntax (@for)**

```html {lineNumbers:true}
@for (item of items; track item.id) {
<div>{{ item.name }}</div>
}

<!-- Track is mandatory! -->
@for (item of items; track $index) {
<div>{{ item.name }}</div>
}
```

> **Important:** track is mandatory in @for - prevents performance issues

---

## layout: default

# @for - Empty State Handling

```html {1-8|10-15}{lineNumbers:true}
<!-- Old: Separate condition check -->
<div *ngIf="books.length === 0">No books available</div>
<div *ngFor="let book of books">{{ book.title }}</div>

<!-- New: Built-in empty block -->
@for (book of books; track book.id) {
<div>{{ book.title }}</div>
} @empty {
<div>No books available</div>
}
```

::left::

**✅ Advantages**

- Single block for iteration and empty state
- No duplicate array checks
- Cleaner template structure

::right::

**🎯 Use Cases**

- Search results with "no results" message
- Shopping cart items
- Data tables with empty states

---

## layout: default

# @switch - Multiple Conditions

```html {1-11|13-23}{lineNumbers:true,maxHeight:'400px'}
<!-- Old: Nested ngSwitch -->
<div [ngSwitch]="userRole">
  <div *ngSwitchCase="'admin'">Admin Dashboard</div>
  <div *ngSwitchCase="'user'">User Dashboard</div>
  <div *ngSwitchDefault>Guest View</div>
</div>

<!-- New: Clear switch syntax -->
@switch (userRole) { @case ('admin') {
<div>Admin Dashboard</div>
} @case ('user') {
<div>User Dashboard</div>
} @default {
<div>Guest View</div>
} }
```

---

## layout: default

# Implicit Variables

::left::

**@for Variables**

```html {lineNumbers:true}
@for (item of items; track item.id) {
<div>
  Index: {{ $index }} First: {{ $first }} Last: {{ $last }} Even: {{ $even }}
  Odd: {{ $odd }} Count: {{ $count }}
</div>
}
```

::right::

**Variable Reference**

| Variable | Description   |
| -------- | ------------- |
| `$index` | Current index |
| `$first` | Is first item |
| `$last`  | Is last item  |
| `$even`  | Even index    |
| `$odd`   | Odd index     |
| `$count` | Total items   |

---

## layout: default

# Type Inference Benefits

```ts {1-7|9-15}{lineNumbers:true}
// Component with type-safe control flow
interface Book {
  id: string;
  title: string;
  author?: string;
}

@Component({
  template: `
    @if (book.author) {
      <!-- TypeScript knows author is defined here -->
      <p>Written by {{ book.author.toUpperCase() }}</p>
    }
  `
})
```

<div class="mt-8 grid grid-cols-2 gap-6">
  <div class="p-4 bg-red-50 dark:bg-red-900/20 rounded-lg">
    <h4 class="font-bold text-red-700 dark:text-red-300">❌ Old *ngIf</h4>
    <p class="text-sm mt-2">Limited type narrowing, needed optional chaining</p>
  </div>
  <div class="p-4 bg-green-50 dark:bg-green-900/20 rounded-lg">
    <h4 class="font-bold text-green-700 dark:text-green-300">✅ New @if</h4>
    <p class="text-sm mt-2">Full type narrowing, TypeScript understands context</p>
  </div>
</div>

---

## layout: center

# Summary: Control Flow Blocks

<div class="grid grid-cols-3 gap-6 mt-12 max-w-5xl mx-auto">
  <div class="p-6 bg-gradient-to-br from-blue-50 to-blue-100 dark:from-blue-900/20 dark:to-blue-800/20 rounded-xl">
    <h3 class="text-2xl font-bold mb-3">@if / @else if / @else</h3>
    <ul class="space-y-2 text-sm">
      <li>✓ Replace *ngIf</li>
      <li>✓ Multiple branches</li>
      <li>✓ Type narrowing</li>
    </ul>
  </div>
  <div class="p-6 bg-gradient-to-br from-green-50 to-green-100 dark:from-green-900/20 dark:to-green-800/20 rounded-xl">
    <h3 class="text-2xl font-bold mb-3">@for / @empty</h3>
    <ul class="space-y-2 text-sm">
      <li>✓ Replace *ngFor</li>
      <li>✓ Mandatory tracking</li>
      <li>✓ Built-in empty state</li>
    </ul>
  </div>
  <div class="p-6 bg-gradient-to-br from-purple-50 to-purple-100 dark:from-purple-900/20 dark:to-purple-800/20 rounded-xl">
    <h3 class="text-2xl font-bold mb-3">@switch / @case / @default</h3>
    <ul class="space-y-2 text-sm">
      <li>✓ Replace ngSwitch</li>
      <li>✓ Multiple cases</li>
      <li>✓ Default fallback</li>
    </ul>
  </div>
</div>
