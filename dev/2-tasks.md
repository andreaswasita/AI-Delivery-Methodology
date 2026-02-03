# Issue #2 - Decompose Methodology Navigator

**Issue:** [#2 - Simplify Methodology Navigator maintenance by separating data from code](https://github.com/andreaswasita/AI-Delivery-Methodology/issues/2)

**Branch:** `feature/decompose-navigator-json`

---

## Tasks

### Phase 1: Extract CSS (30 mins) ✅ COMPLETED

- [x] Create `css/navigator.css`
- [x] Copy all styles from `<style>` tag in `methodology-navigator.html`
- [x] Replace `<style>` block with `<link rel="stylesheet" href="css/navigator.css">`
- [x] Test locally to confirm styles load correctly

### Phase 2: Extract JavaScript Logic (30 mins) ✅ COMPLETED

- [x] Create `js/navigator.js`
- [x] Copy `showTab()`, `showPhaseDetails()`, `filterResources()` functions
- [x] Copy `DOMContentLoaded` event listener
- [x] Replace `<script>` block with `<script src="js/navigator.js"></script>`
- [x] Test locally to confirm functionality works

### Phase 3: Create JSON Data File (1 hour) ✅ COMPLETED

- [x] Create `data/phases.json`
- [x] Convert JavaScript `phases` array to valid JSON format
- [x] Validate JSON syntax (use online validator or VS Code)
- [x] Add `fetch()` call in `navigator.js` to load phases.json
- [x] Update `showPhaseDetails()` to use fetched data
- [x] Test locally with a simple HTTP server

### Phase 4: Documentation (30 mins) ✅ COMPLETED

- [x] Create `data/PHASES-MAINTENANCE-GUIDE.md` explaining how to edit phases.json
- [x] Include example of adding a new phase
- [x] Include common JSON syntax errors to avoid
- [ ] Update main README if needed

### Phase 5: Testing & Validation (30 mins) ⏳ IN PROGRESS

- [x] Test locally with HTTP server - all files load with 200 status
- [ ] Test on GitHub Pages (deploy to test branch first)
- [ ] Verify all 9 phases display correctly
- [ ] Verify all resource links work
- [ ] Verify search/filter functionality works
- [ ] Test on mobile viewport

### Phase 6: Cleanup & PR (15 mins)

- [ ] Remove any debug console.log statements
- [x] Backup original file as `methodology-navigator-backup.html`
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
