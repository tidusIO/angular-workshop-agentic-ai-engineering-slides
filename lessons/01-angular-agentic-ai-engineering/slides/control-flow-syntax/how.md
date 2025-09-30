---
layout: default
---

# Migration Guide: Step by Step

## Migration Strategy

1. Remove CommonModule imports
2. Replace structural directives with control flow blocks
3. Update trackBy functions to inline tracking
4. Test each component after migration
5. Run automated migration tools

---
layout: default
---

# Step 1: Remove CommonModule

```ts
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

**✅ First Win:** Reduced bundle size immediately by removing CommonModule

---
layout: default
---

# Step 2: Migrate \*ngIf to @if

## Real Example from book-item.component.ts

```html
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

```html
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

**💡 Tip:** Keep the same condition logic - just wrap in @if { }

**⚠️ Note:** Don't forget the closing brace }

---
layout: default
---

# Step 3: Migrate \*ngFor to @for

## From book-list.component.ts

```html
<!-- Before: *ngFor with trackBy function -->
<app-book-item *ngFor="let book of books; trackBy: trackById" [book]="book">
</app-book-item>

<!-- After: @for with inline track -->
@for (book of books; track book.id) {
<app-book-item [book]="book"></app-book-item>
}
```

```ts
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

```html
<!-- Before: Complex nested structure -->
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

## From book-list.component.ts - Empty State

```html
<!-- Before: Separate empty check -->
<div *ngIf="filteredBooks.length === 0" class="col-span-full">
  <!-- empty state content -->
</div>
<app-book-item
  *ngFor="let book of filteredBooks; trackBy: trackById"
  [book]="book"
></app-book-item>

<!-- After: Built-in @empty -->
@for (book of filteredBooks; track book.id) {
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

# Step 6: Complex Nested Migration

```html
<!-- Before: Deep nesting nightmare -->
<div *ngIf="user">
  <div *ngIf="user.isAdmin">
    <div *ngIf="user.permissions?.canEdit">
      <span>Admin Editor</span>
    </div>
    <div *ngIf="!user.permissions?.canEdit">
      <span>Admin Viewer</span>
    </div>
  </div>
  <div *ngIf="!user.isAdmin">
    <span>User</span>
  </div>
</div>

<!-- After: Flattened with @else if -->
@if (user?.isAdmin && user.permissions?.canEdit) {
<span>Admin Editor</span>
} @else if (user?.isAdmin) {
<span>Admin Viewer</span>
} @else if (user) {
<span>User</span>
} @else {
<span>User</span>
} } }
```

**Pro Tip:** Consider flattening with @else if when possible

---
layout: default
---

# Common Migration Gotchas

## ❌ Common Mistakes

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

## ✅ Correct Usage

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

---
layout: default
---

# Automated Migration

## Angular CLI Migration Tool

```bash
ng generate @angular/core:control-flow
```

## ✅ What it does

- Automatically converts \*ngIf to @if
- Converts \*ngFor to @for with tracking
- Handles \*ngSwitch conversions
- Removes unnecessary imports

## ⚠️ What to check after

- Verify track expressions are correct
- Test complex nested conditions
- Check TypeScript compilation
- Run unit tests

---
layout: center
---

# Migration Checklist

- [ ] Remove CommonModule from imports
- [ ] Replace \*ngIf with @if blocks
- [ ] Convert \*ngFor to @for with tracking
- [ ] Update \*ngSwitch to @switch
- [ ] Test each component
- [ ] Run automated migration tool
- [ ] Verify TypeScript compilation
- [ ] Run full test suite
