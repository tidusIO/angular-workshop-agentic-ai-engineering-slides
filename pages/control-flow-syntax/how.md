---
layout: default
transition: slide-left
---

# How to Migrate: Step-by-Step

<div class="mt-8 p-6 bg-gradient-to-r from-indigo-50 to-blue-50 dark:from-indigo-900/20 dark:to-blue-900/20 rounded-xl">
  <h2 class="text-2xl font-bold mb-4">Migration Strategy</h2>
  <ol class="space-y-3">
    <li class="flex items-start">
      <span class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">1</span>
      <span>Remove CommonModule imports</span>
    </li>
    <li class="flex items-start">
      <span class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">2</span>
      <span>Replace structural directives with control flow blocks</span>
    </li>
    <li class="flex items-start">
      <span class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">3</span>
      <span>Add tracking to @for loops</span>
    </li>
    <li class="flex items-start">
      <span class="bg-blue-600 text-white rounded-full w-8 h-8 flex items-center justify-center mr-3 flex-shrink-0">4</span>
      <span>Test and verify functionality</span>
    </li>
  </ol>
</div>

---
layout: default
---

# Step 1: Remove CommonModule

```ts {1,6|1,5}{lineNumbers:true}
// Before
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-book-item',
  imports: [CommonModule, RouterModule],
  // ...
})

// After
// No CommonModule import needed!

@Component({
  selector: 'app-book-item',
  imports: [RouterModule], // Only keep what you need
  // ...
})
```

<div class="mt-6 p-4 bg-green-50 dark:bg-green-900/20 rounded-lg">
  <p class="text-green-800 dark:text-green-200">
    <strong>✅ First Win:</strong> Reduced bundle size immediately by removing CommonModule
  </p>
</div>

---
layout: default
---

# Step 2: Migrate \*ngIf to @if

## Real Example from book-item.component.ts

```html {1-7|9-15}{lineNumbers:true}
<!-- Before: Using *ngIf -->
<img
  *ngIf="book.cover"
  [src]="book.cover"
  [alt]="book.title"
  class="w-full h-full object-contain bg-gray-100"
/>

<!-- After: Using @if -->
@if (book.cover) {
<img
  [src]="book.cover"
  [alt]="book.title"
  class="w-full h-full object-contain bg-gray-100"
/>
}
```

---
layout: default
---

# Step 2: Migrate Negated Conditions

```html {1-3|5-9}{lineNumbers:true}
<!-- Before: Negated *ngIf -->
<div
  *ngIf="!book.cover"
  class="w-full h-full bg-gray-100 flex items-center justify-center"
>
  <span class="text-gray-500 text-sm font-medium">No cover available</span>
</div>

<!-- After: Using @if with negation -->
@if (!book.cover) {
<div class="w-full h-full bg-gray-100 flex items-center justify-center">
  <span class="text-gray-500 text-sm font-medium">No cover available</span>
</div>
}
```

<div class="mt-6 grid grid-cols-2 gap-4">
  <div class="p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
    <h4 class="font-bold text-blue-700 dark:text-blue-300">💡 Tip</h4>
    <p class="text-sm mt-2">Keep the same condition logic - just wrap in @if { }</p>
  </div>
  <div class="p-4 bg-yellow-50 dark:bg-yellow-900/20 rounded-lg">
    <h4 class="font-bold text-yellow-700 dark:text-yellow-300">⚠️ Note</h4>
    <p class="text-sm mt-2">Don't forget the closing brace }</p>
  </div>
</div>

---
layout: default
---

# Step 3: Migrate \*ngFor to @for

## From book-list.component.ts

```html {1-3|5-7}{lineNumbers:true,maxHeight:'350px'}
<!-- Before: *ngFor with trackBy function -->
<app-book-item *ngFor="let book of books; trackBy: trackById" [book]="book">
</app-book-item>

<!-- After: @for with inline track -->
@for (book of books; track book.id) {
<app-book-item [book]="book"></app-book-item>
}
```

```ts {lineNumbers:true}
// Before: Needed trackBy function in component
trackById(index: number, book: Book): string {
  return book.id;
}

// After: No function needed! Track directly in template
```

---
layout: default
---

# Step 4: Complex Migration Example

## From book-list.component.ts - Loading State

```html {1-10|12-22}{lineNumbers:true,maxHeight:'400px'}
<!-- Before: Nested divs with *ngIf -->
<div *ngIf="loading" class="flex justify-center items-center py-20">
  <div class="animate-pulse flex flex-col items-center">
    <div class="h-16 w-16 rounded-full border-4 /* ... */ animate-spin"></div>
    <p class="mt-4 text-gray-600">Loading books...</p>
  </div>
</div>

<div *ngIf="!loading" class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4">
  <!-- content -->
</div>

<!-- After: Clean @if/else structure -->
@if (loading) {
<div class="flex justify-center items-center py-20">
  <div class="animate-pulse flex flex-col items-center">
    <div class="h-16 w-16 rounded-full border-4 /* ... */ animate-spin"></div>
    <p class="mt-4 text-gray-600">Loading books...</p>
  </div>
</div>
} @else {
<div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4">
  <!-- content -->
</div>
}
```

---
layout: default
---

# Step 5: Migrate Empty States

## Combining @for with @empty

```html {1-15|17-27}{lineNumbers:true,maxHeight:'450px'}
<!-- Before: Separate empty check -->
<div
  *ngIf="books.length === 0"
  class="col-span-full flex flex-col items-center"
>
  <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-gray-400 mb-4">
    <!-- SVG content -->
  </svg>
  <p class="text-xl font-medium text-gray-600 mb-2">
    {{ searchTerm ? 'No books match your search' : 'No books available' }}
  </p>
</div>

<app-book-item *ngFor="let book of books; trackBy: trackById" [book]="book">
</app-book-item>

<!-- After: Integrated @for/@empty -->
@for (book of books; track book.id) {
<app-book-item [book]="book"></app-book-item>
} @empty {
<div class="col-span-full flex flex-col items-center">
  <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-gray-400 mb-4">
    <!-- SVG content -->
  </svg>
  <p class="text-xl font-medium text-gray-600 mb-2">
    {{ searchTerm ? 'No books match your search' : 'No books available' }}
  </p>
</div>
}
```

---
layout: default
---

# Migration Patterns: Nested Conditions

```html {1-7|9-17}{lineNumbers:true}
<!-- Before: Complex nesting -->
<div *ngIf="user">
  <div *ngIf="user.isActive">
    <span *ngIf="user.role === 'admin'">Admin</span>
    <span *ngIf="user.role !== 'admin'">User</span>
  </div>
</div>

<!-- After: Cleaner structure -->
@if (user) { @if (user.isActive) { @if (user.role === 'admin') {
<span>Admin</span>
} @else {
<span>User</span>
} } }
```

> **Pro Tip:** Consider flattening with @else if when possible

---
layout: default
---

# Common Migration Gotchas

<div class="grid grid-cols-2 gap-6 mt-8">
  <div class="p-6 bg-red-50 dark:bg-red-900/20 rounded-lg">
    <h3 class="text-red-600 dark:text-red-400 font-bold mb-4">❌ Common Mistakes</h3>
    ```html
    <!-- Forgot track -->
    @for (item of items) {
      <div>{{ item }}</div>
    }

    <!-- Wrong syntax -->
    @if book.title {
      <h1>{{ book.title }}</h1>
    }
    ```

  </div>
  <div class="p-6 bg-green-50 dark:bg-green-900/20 rounded-lg">
    <h3 class="text-green-600 dark:text-green-400 font-bold mb-4">✅ Correct Usage</h3>
    ```html
    <!-- Always include track -->
    @for (item of items; track item.id) {
      <div>{{ item }}</div>
    }

    <!-- Parentheses required -->
    @if (book.title) {
      <h1>{{ book.title }}</h1>
    }
    ```

  </div>
</div>

---
layout: default
---

# Automated Migration

<div class="mt-8 p-6 bg-gradient-to-r from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 rounded-xl">
  <h2 class="text-2xl font-bold mb-4">Angular CLI Migration Tool</h2>
  <div class="mt-4">
```bash
ng generate @angular/core:control-flow
```
  </div>
</div>

<div class="mt-8 grid grid-cols-2 gap-6">
  <div>
    <h3 class="text-lg font-bold mb-3">✅ What it does</h3>
    <ul class="space-y-2 text-sm">
      <li>• Automatically converts *ngIf to @if</li>
      <li>• Converts *ngFor to @for with tracking</li>
      <li>• Handles *ngSwitch conversions</li>
      <li>• Removes unnecessary imports</li>
    </ul>
  </div>
  <div>
    <h3 class="text-lg font-bold mb-3">⚠️ Manual Review Needed</h3>
    <ul class="space-y-2 text-sm">
      <li>• Complex template expressions</li>
      <li>• Custom trackBy logic</li>
      <li>• Nested template references</li>
      <li>• Edge cases and formatting</li>
    </ul>
  </div>
</div>

---
layout: center
---

# Migration Checklist

<div class="max-w-2xl mx-auto">
  <div class="space-y-4">
    <label class="flex items-center p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-shadow">
      <input type="checkbox" class="w-5 h-5 text-blue-600 rounded mr-4">
      <span>Remove CommonModule from imports</span>
    </label>
    <label class="flex items-center p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-shadow">
      <input type="checkbox" class="w-5 h-5 text-blue-600 rounded mr-4">
      <span>Replace *ngIf with @if blocks</span>
    </label>
    <label class="flex items-center p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-shadow">
      <input type="checkbox" class="w-5 h-5 text-blue-600 rounded mr-4">
      <span>Convert *ngFor to @for with track</span>
    </label>
    <label class="flex items-center p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-shadow">
      <input type="checkbox" class="w-5 h-5 text-blue-600 rounded mr-4">
      <span>Add @empty blocks where appropriate</span>
    </label>
    <label class="flex items-center p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-shadow">
      <input type="checkbox" class="w-5 h-5 text-blue-600 rounded mr-4">
      <span>Update ngSwitch to @switch</span>
    </label>
    <label class="flex items-center p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm hover:shadow-md transition-shadow">
      <input type="checkbox" class="w-5 h-5 text-blue-600 rounded mr-4">
      <span>Test all functionality</span>
    </label>
  </div>
</div>
