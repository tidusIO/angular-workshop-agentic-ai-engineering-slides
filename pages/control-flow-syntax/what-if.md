---
layout: default
transition: slide-left
---

# What If: Edge Cases & Advanced Patterns

<div class="mt-8 p-6 bg-gradient-to-r from-orange-50 to-red-50 dark:from-orange-900/20 dark:to-red-900/20 rounded-xl">
  <h2 class="text-2xl font-bold mb-4">Exploring Beyond the Basics</h2>
  <p class="text-gray-700 dark:text-gray-300">Let's dive into complex scenarios, edge cases, and creative solutions with modern control flow</p>
</div>

---
layout: default
---

# What If: Complex Async Patterns?

```html {lineNumbers:true,maxHeight:'450px'}
<!-- Traditional Observable approach -->
<div *ngIf="data$ | async as data; else loading">
  <div *ngIf="data.items?.length > 0; else empty">
    <div *ngFor="let item of data.items">{{ item.name }}</div>
  </div>
  <ng-template #empty> No items found </ng-template>
</div>
<ng-template #loading>Loading...</ng-template>

<!-- Modern approach with signals -->
@if (loading()) {
<div>Loading...</div>
} @else if (error()) {
<div>Error: {{ error() }}</div>
} @else { @for (item of items(); track item.id) {
<div>{{ item.name }}</div>
} @empty {
<div>No items found</div>
} }
```

---
layout: default
---

# What If: Dynamic Component Loading?

```ts {lineNumbers:true}
// Combining @if with dynamic components
@Component({
  template: `
    @switch (componentType) {
      @case ("chart") {
        <app-chart-component [data]="data" />
      }
      @case ("table") {
        <app-table-component [data]="data" />
      }
      @case ("grid") {
        <app-grid-component [data]="data" />
      }
      @default {
        <div>Unknown component type</div>
      }
    }
  `,
})
export class DynamicViewComponent {
  componentType = signal<string>("chart");
  data = signal<any[]>([]);

  switchView(type: string) {
    this.componentType.set(type);
  }
}
```

---
layout: default
---

# What If: Nested Loops with Filtering?

```html {lineNumbers:true}
<!-- Complex nested structure -->
@for (category of categories(); track category.id) {
<h2>{{ category.name }}</h2>
@for (item of category.items; track item.id) { @if (item.isActive && item.price
> minPrice) {
<div class="item">{{ item.name }} - ${{ item.price }}</div>
} } @empty {
<p>No active items in this category</p>
}

<!-- Alternative: Pre-filter in component -->
@for (category of filteredCategories(); track category.id) {
<h2>{{ category.name }}</h2>
@for (item of category.activeItems; track item.id) {
<div class="item">{{ item.name }} - ${{ item.price }}</div>
}
```

<div class="mt-4 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg">
  <p class="text-blue-800 dark:text-blue-200">
    <strong>Best Practice:</strong> Pre-filter data in computed signals for better performance
  </p>
</div>

---
layout: default
---

# What If: Form Validation States?

```html {lineNumbers:true,maxHeight:'400px'}
<!-- Multi-state form field validation -->
<div class="form-field">
  <input
    #emailInput
    type="email"
    [(ngModel)]="email"
    (blur)="validateEmail()"
  />

  @if (emailInput.touched) { @if (!email()) {
  <span class="error">Email is required</span>
  } @else if (!isValidEmail(email())) {
  <span class="error">Invalid email format</span>
  } @else if (isCheckingAvailability()) {
  <span class="info">Checking availability...</span>
  } @else if (!isEmailAvailable()) {
  <span class="error">Email already taken</span>
  } @else {
  <span class="success">✓ Email available</span>
  } }
</div>
```

---
layout: default
---

# What If: Recursive Templates?

```html {lineNumbers:true,maxHeight:'400px'}
<!-- Tree structure with recursive rendering -->
@Component({ selector: 'app-tree-node', template: `
<div class="node">
  <span (click)="toggle()">
    @if (hasChildren()) { {{ expanded() ? '▼' : '▶' }} } {{ node.name }}
  </span>

  @if (expanded() && hasChildren()) {
  <div class="children">
    @for (child of node.children; track child.id) {
    <app-tree-node [node]="child" />
    }
  </div>
  }
</div>
` }) export class TreeNodeComponent { @Input() node!: TreeNode; expanded =
signal(false); hasChildren = computed(() => this.node.children &&
this.node.children.length > 0 ); toggle() { this.expanded.update(v => !v); } }
```

---
layout: default
---

# What If: Performance Optimization?

<div class="grid grid-cols-2 gap-6">
  <div>
    <h3 class="text-lg font-bold mb-3 text-red-600 dark:text-red-400">⚠️ Avoid</h3>
```html
<!-- Expensive computation in template -->
@for (item of items; track item.id) {
  @if (complexCalculation(item) > threshold) {
    <div>{{ item.name }}</div>
  }
}
```
  </div>
  <div>
    <h3 class="text-lg font-bold mb-3 text-green-600 dark:text-green-400">✅ Prefer</h3>
```html
<!-- Pre-computed values -->
@for (item of processedItems(); track item.id) {
  @if (item.meetsThreshold) {
    <div>{{ item.name }}</div>
  }
}
```
  </div>
</div>

```ts {lineNumbers:true}
// Use computed signals for derived state
processedItems = computed(() =>
  this.items().map((item) => ({
    ...item,
    meetsThreshold: this.complexCalculation(item) > this.threshold(),
  })),
);
```

---
layout: default
---

# What If: Server-Side Rendering (SSR)?

```html {lineNumbers:true}
<!-- SSR-aware conditional rendering -->
@if (isPlatformBrowser()) {
<!-- Browser-only content -->
<div class="interactive-chart">
  <canvas #chartCanvas></canvas>
</div>
} @else {
<!-- SSR fallback -->
<div class="chart-placeholder">
  <img src="chart-preview.png" alt="Chart preview" />
</div>
}

<!-- Deferred loading for better performance -->
@defer (on viewport) {
<app-heavy-component />
} @placeholder {
<div class="skeleton-loader"></div>
} @loading (minimum 200ms) {
<div class="spinner"></div>
}
```

---
layout: default
---

# What If: Migration Challenges?

<div class="grid grid-cols-2 gap-6 mt-8">
  <div class="p-4 bg-yellow-50 dark:bg-yellow-900/20 rounded-lg">
    <h3 class="font-bold text-yellow-700 dark:text-yellow-300 mb-3">Challenge</h3>
    <p class="text-sm mb-2">Complex template with multiple ng-templates</p>
```html
<ng-container *ngTemplateOutlet="
  isAdmin ? adminTpl : userTpl;
  context: { data: userData }
"></ng-container>
```
  </div>
  <div class="p-4 bg-green-50 dark:bg-green-900/20 rounded-lg">
    <h3 class="font-bold text-green-700 dark:text-green-300 mb-3">Solution</h3>
    <p class="text-sm mb-2">Use @if with component composition</p>
```html
@if (isAdmin) {
  <app-admin-view [data]="userData" />
} @else {
  <app-user-view [data]="userData" />
}
```
  </div>
</div>

---
layout: default
---

# What If: Future Possibilities?

<div class="mt-8 space-y-6">
  <div class="p-6 bg-gradient-to-r from-purple-50 to-indigo-50 dark:from-purple-900/20 dark:to-indigo-900/20 rounded-xl">
    <h3 class="text-xl font-bold mb-3">🚀 Upcoming Features</h3>
    <ul class="space-y-2">
      <li>• @defer for lazy loading components</li>
      <li>• @placeholder for loading states</li>
      <li>• @error for error boundaries</li>
      <li>• Enhanced type inference</li>
    </ul>
  </div>

  <div class="p-6 bg-gradient-to-r from-blue-50 to-cyan-50 dark:from-blue-900/20 dark:to-cyan-900/20 rounded-xl">
    <h3 class="text-xl font-bold mb-3">💡 Best Practices Evolution</h3>
    <ul class="space-y-2">
      <li>• Signals + Control Flow = Reactive templates</li>
      <li>• Computed properties for complex conditions</li>
      <li>• Component composition over complex templates</li>
      <li>• Performance-first template design</li>
    </ul>
  </div>
</div>

---
layout: center
---

# Creative Applications

<div class="grid grid-cols-2 gap-8 mt-12 max-w-4xl mx-auto">
  <div class="p-6 bg-white dark:bg-gray-800 rounded-xl shadow-lg">
    <h3 class="text-xl font-bold mb-4">Dynamic Forms</h3>
```html
 @for (field of formFields(); track field.id) {
   @switch (field.type) {
     @case ('text') {
       <input type="text" />
     }
     @case ('select') {
       <select><!-- options --></select>
     }
   }
 }
```
  </div>
  <div class="p-6 bg-white dark:bg-gray-800 rounded-xl shadow-lg">
    <h3 class="text-xl font-bold mb-4">Wizard Steps</h3>
```html
@switch (currentStep()) {
   @case (1) {
     <app-step-one />
   }
   @case (2) {
     <app-step-two />
   }
   @case (3) {
     <app-step-three />
   }
}
```
  </div>
</div>
