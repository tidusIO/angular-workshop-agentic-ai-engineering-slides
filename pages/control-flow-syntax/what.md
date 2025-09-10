---
layout: default
transition: slide-left
---

# Core Concepts: Modern Control Flow

## Three Essential Control Flow Blocks

- **@if** - Conditional rendering
- **@for** - List iteration
- **@switch** - Multiple conditions

---
layout: two-cols
---

# @if - Conditional Rendering

::left::

**Old Syntax (\*ngIf)**

```html
<!-- Simple condition -->
<div *ngIf="isVisible">Content</div>

<!-- With else -->
<div *ngIf="condition; else other">Primary content</div>
<ng-template #other> Alternative content </ng-template>
```

::right::

**New Syntax (@if)**

```html
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
layout: default
---

# @if - Multiple Branches

```html
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

**Benefit:** @else if chains eliminate complex nesting

---
layout: two-cols
---

# @for - List Iteration

::left::

**Old Syntax (\*ngFor)**

```html
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

```html
@for (item of items; track item.id) {
<div>{{ item.name }}</div>
}

<!-- Track is mandatory! -->
@for (item of items; track $index) {
<div>{{ item.name }}</div>
}
```

**Important:** track is mandatory in @for - prevents performance issues

---
layout: two-cols
---

# @for - Empty State Handling

::left::

```html
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

::right::

**✅ Advantages**

- Single block for iteration and empty state
- No duplicate array checks
- Cleaner template structure

**🎯 Use Cases**

- Search results with "no results" message
- Shopping cart items
- Data tables with empty states

---
layout: default
---

# @switch - Multiple Conditions

```html
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
layout: two-cols
---

# Implicit Variables

::left::

**@for Variables**

```html
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
layout: default
---

# Type Inference Benefits

```ts
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

## Comparison

**❌ Old \*ngIf:** Limited type narrowing, needed optional chaining

**✅ New @if:** Full type narrowing, TypeScript understands context

---
layout: center
---

# Summary: Control Flow Blocks

## @if / @else if / @else

- ✓ Replace \*ngIf
- ✓ Multiple branches
- ✓ Type narrowing

## @for / @empty

- ✓ Replace \*ngFor
- ✓ Mandatory tracking
- ✓ Built-in empty state

## @switch / @case / @default

- ✓ Replace ngSwitch
- ✓ Multiple cases
- ✓ Default fallback
