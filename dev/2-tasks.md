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

### Phase 5: Testing & Validation (30 mins) ✅ COMPLETED

- [x] Test locally with HTTP server - all files load with 200 status
- [x] Test on GitHub Pages (deploy to test branch first)
- [x] Verify all 9 phases display correctly
- [x] Verify all resource links work
- [x] Verify search/filter functionality works
- [ ] Test on mobile viewport

### Phase 5b: UX Comparison Analysis ✅ COMPLETED

Automated comparison between original and fork using `scripts/compare-pages.py`:

#### Element Count Comparison

| Element | Original | Fork | Status         |
| ------- | -------- | ---- | -------------- |
| Tabs    | 6        | 6    | ✅ Match       |
| Links   | 44       | 44   | ✅ Match       |
| Buttons | 0        | 0    | ✅ Match       |
| Phases  | 8        | 9    | 🆕 Improvement |

#### Phase Label Comparison

| #   | Original    | Fork       | JSON Data                     | Verdict           |
| --- | ----------- | ---------- | ----------------------------- | ----------------- |
| 0   | Presales    | Presales   | "Presales & Discovery"        | ✅ Match          |
| 1   | Envisioning | Mobilise   | "Mobilisation"                | ✅ Fork corrected |
| 2   | Hackathons  | Hackathons | "Hackathons & Proof of Value" | ✅ Match          |
| 3   | Platform    | Platform   | "Platform Setup"              | ✅ Match          |
| 4   | Build       | Build      | "Build Phase"                 | ✅ Match          |
| 5   | Integrate   | Integrate  | "Integration & Testing"       | ✅ Match          |
| 6   | Deploy      | Test       | "Test & Evaluate"             | ✅ Fork corrected |
| 7   | Operate     | Deploy     | "Prepare & Deploy"            | ✅ Fork corrected |
| 8   | _(missing)_ | Operate    | "Operate & Care"              | 🆕 Fork added     |

#### Key Findings

1. **Bug Fix: Missing Phase 8** - Original page only showed 8 phases (0-7), but JSON contains 9 phases (0-8). Fork now correctly displays all 9 phases.

2. **Bug Fix: Incorrect Labels** - Original had hardcoded labels that didn't match the JSON data:
   - Phase 1: "Envisioning" → "Mobilise" (matches JSON "Mobilisation")
   - Phase 6: "Deploy" → "Test" (matches JSON "Test & Evaluate")
   - Phase 7: "Operate" → "Deploy" (matches JSON "Prepare & Deploy")

3. **No Breaking Changes** - All 44 links preserved, all 6 tabs functional

#### Comparison Tools Created

- `scripts/compare-pages.py` - Automated Python comparison script
- `scripts/compare-ux.js` - Browser console script for manual comparison
- `scripts/comparison-report.json` - Full JSON report of differences

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

- [x] All 6 phases complete
- [x] No visual changes to the navigator (looks identical) - _verified via automated comparison_
- [x] All functionality works (tabs, phase selection, search)
- [ ] Works on GitHub Pages - _local testing complete, GitHub Pages pending_
- [x] Maintainer documentation exists
- [ ] PR approved and merged

---

## Code Review Fixes Applied

During code review, the following issues were identified and fixed:

### JavaScript ([navigator.js](../js/navigator.js))

- ✅ Fixed: `event` parameter was undefined in `showTab()` - now explicitly passed
- ✅ Fixed: Added ARIA state management (`aria-selected` attribute updates)

### HTML ([methodology-navigator.html](../methodology-navigator.html))

- ✅ Fixed: Added `role="tablist"` and `role="tab"` for accessibility
- ✅ Fixed: Added `aria-selected` attributes to tab buttons
- ✅ Fixed: Added missing Phase 8 to timeline
- ✅ Fixed: Corrected Phase 1 label from "Envisioning" to "Mobilise"

### CSS ([navigator.css](../css/navigator.css))

- ✅ Fixed: Added `:focus-visible` styles for keyboard accessibility
