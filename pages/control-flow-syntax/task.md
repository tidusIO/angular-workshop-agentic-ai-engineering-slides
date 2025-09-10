---
layout: cover
background: https://images.unsplash.com/photo-1486312338219-ce68d2c6f44d?w=1920
transition: slide-left
---

# Hands-On Exercise

## Migrate to Modern Control Flow Syntax

<div class="mt-8 text-xl">
  Transform your Angular components from structural directives to modern control flow
</div>

---
layout: default
---

# Exercise Overview

<div class="mt-8 p-6 bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 rounded-xl">
  <h2 class="text-2xl font-bold mb-4">Your Mission</h2>
  <p class="text-lg mb-4">Migrate the book management application to use modern control flow syntax</p>

  <div class="grid grid-cols-2 gap-6 mt-6">
    <div>
      <h3 class="font-bold mb-2">📁 Files to Migrate</h3>
      <ul class="space-y-1 text-sm">
        <li>• book-list.component.ts</li>
        <li>• book-item.component.ts</li>
        <li>• book-detail.component.ts</li>
        <li>• book-edit.component.ts</li>
      </ul>
    </div>
    <div>
      <h3 class="font-bold mb-2">⏱️ Time Estimate</h3>
      <ul class="space-y-1 text-sm">
        <li>• Basic migration: 20 minutes</li>
        <li>• With optimizations: 30 minutes</li>
        <li>• Full refactoring: 45 minutes</li>
      </ul>
    </div>
  </div>
</div>

---
layout: default
---

# Task 1: Basic Migration

## Start with book-item.component.ts

```ts {lineNumbers:true,maxHeight:'400px'}
// Current code with *ngIf
@Component({
  selector: "app-book-item",
  standalone: true,
  imports: [CommonModule, RouterModule],
  template: `
    <div class="book-card">
      <img *ngIf="book.cover" [src]="book.cover" [alt]="book.title" />
      <div *ngIf="!book.cover" class="no-cover">No cover available</div>

      <h2>{{ book.title }}</h2>
      <p *ngIf="book.subtitle">{{ book.subtitle }}</p>
      <p *ngIf="book.isbn">ISBN: {{ book.isbn }}</p>
    </div>
  `,
})
export class BookItemComponent {
  @Input() book!: Book;
}
```

### Your Task:

1. Remove CommonModule import
2. Replace all \*ngIf with @if
3. Test that the component still works

---
layout: default
---

# Task 2: List Migration

## Migrate book-list.component.ts

```html {lineNumbers:true,maxHeight:'350px'}
<!-- Current template section -->
<div *ngIf="loading" class="loading">Loading books...</div>

<div *ngIf="!loading" class="book-grid">
  <app-book-item *ngFor="let book of books; trackBy: trackById" [book]="book">
  </app-book-item>

  <div *ngIf="books.length === 0" class="empty-state">No books available</div>
</div>
```

### Your Task:

1. Convert loading state to @if/@else
2. Replace \*ngFor with @for (include track!)
3. Use @empty instead of separate empty check
4. Remove the trackById method

---
layout: default
---

# Task 3: Complex Conditions

## Enhance book-detail.component.ts

```html {lineNumbers:true,maxHeight:'350px'}
<!-- Add these conditions to your template -->
<div class="book-detail">
  <!-- Show loading state -->
  <!-- If loaded, show book details -->
  <!-- Show edit button only for authenticated users -->
  <!-- Show delete button only for admins -->
  <!-- Handle error state -->
</div>
```

### Requirements:

```ts
// Use these signals in your component
loading = signal(false);
error = signal<string | null>(null);
book = signal<Book | null>(null);
isAuthenticated = signal(true);
isAdmin = signal(false);
```

### Your Implementation:

- Use @if with @else if chains
- Implement proper type narrowing
- Handle all states elegantly

---
layout: default
---

# Task 4: Form States

## Improve book-edit.component.ts

<div class="grid grid-cols-2 gap-6">
  <div>
    <h3 class="text-lg font-bold mb-3">Current State</h3>
    ```html
    <form>
      <div *ngIf="!isValid" class="error">
        Please fix errors
      </div>
      <button *ngIf="!saving">Save</button>
      <div *ngIf="saving">Saving...</div>
    </form>
    ```
  </div>
  <div>
    <h3 class="text-lg font-bold mb-3">Target State</h3>
    ```html
    <form>
      @if (!isValid()) {
        <div class="error">
          <!-- Show specific errors -->
        </div>
      }
      @if (saving()) {
        <div>Saving...</div>
      } @else {
        <button>Save</button>
      }
    </form>
    ```
  </div>
</div>

### Bonus Challenge:

Add field-specific validation messages using nested @if blocks

---
layout: default
---

# Task 5: Performance Optimization

## Advanced Challenge

```ts {lineNumbers:true}
// Create a filtered and sorted book list
export class BookListComponent {
  books = signal<Book[]>([]);
  searchTerm = signal("");
  sortBy = signal<"title" | "author" | "year">("title");

  // Create computed signal for filtered books
  filteredBooks = computed(() => {
    // Your implementation here
  });

  // Create computed signal for sorted books
  sortedBooks = computed(() => {
    // Your implementation here
  });
}
```

### Template Requirements:

1. Use @for with the computed signals
2. Show different messages for no results vs. no books
3. Add loading skeleton with @defer (bonus)

---
layout: default
---

# Task 6: Testing Your Migration

## Verification Checklist

<div class="mt-6 space-y-4">
  <div class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm">
    <h3 class="font-bold mb-2">✅ Functionality Tests</h3>
    <ul class="space-y-2 text-sm">
      <li>☐ All conditional content appears correctly</li>
      <li>☐ Lists render with proper tracking</li>
      <li>☐ Empty states display when appropriate</li>
      <li>☐ Forms validate and submit properly</li>
    </ul>
  </div>

  <div class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm">
    <h3 class="font-bold mb-2">🎯 Code Quality</h3>
    <ul class="space-y-2 text-sm">
      <li>☐ No CommonModule imports remain</li>
      <li>☐ All @for loops have track expressions</li>
      <li>☐ Conditions use parentheses in @if</li>
      <li>☐ No linting errors</li>
    </ul>
  </div>

  <div class="p-4 bg-white dark:bg-gray-800 rounded-lg shadow-sm">
    <h3 class="font-bold mb-2">⚡ Performance</h3>
    <ul class="space-y-2 text-sm">
      <li>☐ Bundle size reduced (check with `ng build --stats-json`)</li>
      <li>☐ No unnecessary re-renders</li>
      <li>☐ Computed signals for derived state</li>
    </ul>
  </div>
</div>

---
layout: default
---

# Bonus Challenges

<div class="grid grid-cols-2 gap-6 mt-8">
  <div class="p-6 bg-gradient-to-br from-purple-50 to-pink-50 dark:from-purple-900/20 dark:to-pink-900/20 rounded-xl">
    <h3 class="text-xl font-bold mb-4">🎯 Challenge 1: Auto-Migration</h3>
    <p class="text-sm mb-3">Use the Angular CLI migration schematic:</p>
    ```bash
    ng generate @angular/core:control-flow
    ```
    <p class="text-sm mt-3">Compare the results with your manual migration</p>
  </div>

  <div class="p-6 bg-gradient-to-br from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 rounded-xl">
    <h3 class="text-xl font-bold mb-4">🚀 Challenge 2: Advanced Patterns</h3>
    <p class="text-sm mb-3">Implement these patterns:</p>
    <ul class="text-sm space-y-1">
      <li>• Recursive component with @if/@for</li>
      <li>• Multi-step form with @switch</li>
      <li>• Virtual scrolling with @for</li>
    </ul>
  </div>
</div>

<div class="mt-6 p-6 bg-gradient-to-br from-green-50 to-emerald-50 dark:from-green-900/20 dark:to-emerald-900/20 rounded-xl">
  <h3 class="text-xl font-bold mb-4">💡 Challenge 3: Create a Custom Migration Tool</h3>
  <p class="text-sm">Write a Node.js script that:</p>
  <ul class="text-sm space-y-1 mt-3">
    <li>• Finds all components with structural directives</li>
    <li>• Generates a migration report</li>
    <li>• Suggests optimal control flow replacements</li>
  </ul>
</div>

---
layout: default
---

# Solution Hints

<div class="space-y-6">
  <details class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
    <summary class="font-bold cursor-pointer">💡 Hint 1: Track Expression</summary>

    ```html
    <!-- If items have unique IDs -->
    @for (item of items; track item.id) { }

    <!-- For primitive arrays -->
    @for (item of items; track item) { }

    <!-- Using index (last resort) -->
    @for (item of items; track $index) { }
    ```

  </details>

  <details class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
    <summary class="font-bold cursor-pointer">💡 Hint 2: Complex Conditions</summary>

    ```html
    @if (loading()) {
      <div>Loading...</div>
    } @else if (error()) {
      <div>Error: {{ error() }}</div>
    } @else if (data()) {
      <div>{{ data() }}</div>
    } @else {
      <div>No data</div>
    }
    ```

  </details>

  <details class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
    <summary class="font-bold cursor-pointer">💡 Hint 3: Computed Signals</summary>

    ```ts
    filteredBooks = computed(() => {
      const term = this.searchTerm().toLowerCase();
      return this.books().filter(book =>
        book.title.toLowerCase().includes(term) ||
        book.author.toLowerCase().includes(term)
      );
    });
    ```

  </details>
</div>

---
layout: center
---

# Ready to Start?

<div class="text-center">
  <div class="text-6xl mb-8">💪</div>
  <h2 class="text-3xl font-bold mb-6">Time to Modernize Your Angular Code!</h2>

  <div class="mt-8 space-y-4">
    <p class="text-xl">Remember the key principles:</p>
    <ul class="text-lg space-y-2 max-w-2xl mx-auto text-left">
      <li>✅ Remove CommonModule imports</li>
      <li>✅ Always include track in @for</li>
      <li>✅ Use parentheses in @if conditions</li>
      <li>✅ Leverage @empty for better UX</li>
      <li>✅ Embrace computed signals</li>
    </ul>
  </div>

  <div class="mt-12">
    <a href="https://angular.dev/guide/templates/control-flow"
       target="_blank"
       class="inline-block px-8 py-4 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition-colors text-xl font-semibold">
      📚 View Documentation
    </a>
  </div>
</div>
