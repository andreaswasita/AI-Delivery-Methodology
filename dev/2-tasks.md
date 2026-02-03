# Issue #2 - Decompose Methodology Navigator

**Issue:** [#2 - Simplify Methodology Navigator maintenance by separating data from code](https://github.com/andreaswasita/AI-Delivery-Methodology/issues/2)

**Branch:** `feature/decompose-navigator-json`

---

## Tasks

### Phase 1: Extract CSS (30 mins)

- [ ] Create `css/navigator.css`
- [ ] Copy all styles from `<style>` tag in `methodology-navigator.html`
- [ ] Replace `<style>` block with `<link rel="stylesheet" href="css/navigator.css">`
- [ ] Test locally to confirm styles load correctly

### Phase 2: Extract JavaScript Logic (30 mins)

- [ ] Create `js/navigator.js`
- [ ] Copy `showTab()`, `showPhaseDetails()`, `filterResources()` functions
- [ ] Copy `DOMContentLoaded` event listener
- [ ] Replace `<script>` block with `<script src="js/navigator.js"></script>`
- [ ] Test locally to confirm functionality works

### Phase 3: Create JSON Data File (1 hour)

- [ ] Create `data/phases.json`
- [ ] Convert JavaScript `phases` array to valid JSON format
- [ ] Validate JSON syntax (use online validator or VS Code)
- [ ] Add `fetch()` call in `navigator.js` to load phases.json
- [ ] Update `showPhaseDetails()` to use fetched data
- [ ] Test locally with a simple HTTP server

### Phase 4: Documentation (30 mins)

- [ ] Create `data/README.md` explaining how to edit phases.json
- [ ] Include example of adding a new phase
- [ ] Include common JSON syntax errors to avoid
- [ ] Update main README if needed

### Phase 5: Testing & Validation (30 mins)

- [ ] Test on GitHub Pages (deploy to test branch first)
- [ ] Verify all 9 phases display correctly
- [ ] Verify all resource links work
- [ ] Verify search/filter functionality works
- [ ] Test on mobile viewport

### Phase 6: Cleanup & PR (15 mins)

- [ ] Remove any debug console.log statements
- [ ] Commit all changes with clear messages
- [ ] Create Pull Request linking to Issue #2
- [ ] Request review

---

## Files to Create

| File                | Purpose                                       |
| ------------------- | --------------------------------------------- |
| `css/navigator.css` | All styles extracted from HTML                |
| `js/navigator.js`   | Tab switching, phase details, filtering logic |
| `data/phases.json`  | Phase data in maintainer-friendly format      |
| `data/README.md`    | Instructions for maintainers                  |

---

## Files to Modify

| File                         | Changes                                       |
| ---------------------------- | --------------------------------------------- |
| `methodology-navigator.html` | Remove inline CSS/JS, add external file links |

---

## Testing Commands

```bash
# Start local server for testing (from repo root)
python -m http.server 8000

# Then open in browser
# http://localhost:8000/methodology-navigator.html
```

---

## Definition of Done

- [ ] All 6 phases complete
- [ ] No visual changes to the navigator (looks identical)
- [ ] All functionality works (tabs, phase selection, search)
- [ ] Works on GitHub Pages
- [ ] Maintainer documentation exists
- [ ] PR approved and merged
