# Phase Data Maintenance Guide

This guide explains how to edit `phases.json` to update the AI Delivery Methodology Navigator content. **Non-developers can safely edit this file** without touching any code.

---

## ⚡ Quick Start (Most Common Edits)

**To change phase text (duration, description, etc.):**

1. Open `data/phases.json` in any text editor
2. Find the phase by searching for its name (e.g., "Mobilisation")
3. Change the text inside the quotes
4. Save the file

**Example - changing duration:**

```json
"duration": "3-5 weeks"
```

**To add a bullet point (objective or deliverable):**

1. Find the `"objectives"` or `"deliverables"` section
2. Add your new item in quotes
3. Put a comma after the previous item

**Example:**

```json
"objectives": [
    "Existing objective",
    "New objective here"
]
```

**That's it!** For more details, see below.

---

## 🔧 How to Edit phases.json (Detailed)

### Step 1: Open the File

Open `data/phases.json` in any text editor (VS Code recommended for syntax highlighting).

### Step 2: Find the Phase to Edit

Each phase is a block that looks like this:

```json
{
  "number": 0,
  "name": "Presales & Discovery",
  "duration": "2-4 weeks",
  "team": "2-4 people",
  "description": "Initial assessment and opportunity...",
  "objectives": ["Understand business needs", "Assess AI readiness"],
  "deliverables": [
    "Opportunity Qualification Report",
    "Business Requirements Document"
  ],
  "resources": {
    "checklist": "markdown-viewer.html?file=checklists/00-presales-discovery-checklist.md",
    "guide": "markdown-viewer.html?file=guides/phases/00-presales-discovery-activities.md"
  }
}
```

### Step 3: Make Your Changes

**To change text:** Simply update the value in quotes.

```json
"duration": "3-5 weeks"   // Changed from "2-4 weeks"
```

**To add an objective:** Add a new line in the objectives array.

```json
"objectives": [
    "Understand business needs",
    "Assess AI readiness",
    "New objective here"   // ← Added (don't forget the comma above!)
]
```

**To add a resource link:**

```json
"resources": {
    "checklist": "...",
    "guide": "...",
    "newresource": "path/to/new-resource.html"   // ← Added
}
```

### Step 4: Validate Your JSON

Before saving, validate your JSON to catch syntax errors:

1. **VS Code:** Install the "JSON" extension - it will show red underlines for errors
2. **Online:** Paste your JSON at [jsonlint.com](https://jsonlint.com)
3. **Command line:** `python -m json.tool data/phases.json`

### Step 5: Test Locally

```bash
# From the repository root
python -m http.server 8000

# Open http://localhost:8000/methodology-navigator.html
```

---

## ⚠️ Common Mistakes to Avoid

### 1. Missing Commas

**Wrong:**

```json
{
    "name": "Build Phase"
    "duration": "8-16 weeks"   // ← Missing comma after "Build Phase"
}
```

**Correct:**

```json
{
  "name": "Build Phase",
  "duration": "8-16 weeks"
}
```

### 2. Trailing Commas

**Wrong:**

```json
{
  "objectives": [
    "First objective",
    "Second objective" // ← Extra comma on last item
  ]
}
```

**Correct:**

```json
{
  "objectives": [
    "First objective",
    "Second objective" // ← No comma on last item
  ]
}
```

### 3. Unescaped Quotes

**Wrong:**

```json
{
    "description": "Use the "Five Whys" technique"
}
```

**Correct:**

```json
{
  "description": "Use the \"Five Whys\" technique"
}
```

### 4. Wrong File Paths

All resource paths are **relative to the repository root**, not to the data folder.

**Wrong:**

```json
"checklist": "../checklists/00-presales-discovery-checklist.md"
```

**Correct:**

```json
"checklist": "markdown-viewer.html?file=checklists/00-presales-discovery-checklist.md"
```

---

## 📋 Phase Structure Reference

| Field          | Type             | Required | Description                           |
| -------------- | ---------------- | -------- | ------------------------------------- |
| `number`       | Integer          | ✅       | Phase number (0-8)                    |
| `name`         | String           | ✅       | Display name                          |
| `duration`     | String           | ✅       | Typical duration (e.g., "2-4 weeks")  |
| `team`         | String           | ✅       | Team size (e.g., "4-6 people")        |
| `description`  | String           | ✅       | One paragraph description             |
| `objectives`   | Array of Strings | ✅       | Key objectives (bullet points)        |
| `deliverables` | Array of Strings | ✅       | Expected deliverables (bullet points) |
| `resources`    | Object           | ✅       | Links to resources (see below)        |

### Resource Keys

| Key            | Icon | Button Style   |
| -------------- | ---- | -------------- |
| `checklist`    | ✅   | Primary (blue) |
| `guide`        | 📖   | Secondary      |
| `workshop`     | 🎯   | Secondary      |
| `template`     | 📝   | Secondary      |
| `templates`    | 📝   | Secondary      |
| `calculator`   | 🧮   | Secondary      |
| `assessment`   | 🎯   | Secondary      |
| `deploy`       | 🚀   | Green          |
| `mlops`        | 🔄   | Secondary      |
| `coe`          | 🏢   | Secondary      |
| `day1ops`      | 🚀   | Secondary      |
| `hypercare`    | 🏥   | Secondary      |
| `valuetracker` | 📊   | Secondary      |
| `riskguide`    | ⚠️   | Secondary      |

---

## 🆕 Adding a New Phase

1. Copy an existing phase block
2. Update the `number` field (phases are 0-indexed)
3. Update all other fields
4. Add the new phase at the end of the array (before the final `]`)
5. Don't forget the comma after the previous phase's closing `}`

**Example:**

```json
    },     // ← Comma after previous phase
    {
        "number": 9,
        "name": "New Phase Name",
        ...
    }
]      // ← No comma on last phase
```

---

## 🔄 Syncing with methodology_phases.py

The Python agents also use phase data in `agents/methodology_phases.py`. If you add or modify phases, consider updating both files to keep them in sync.

---

## ❓ Need Help?

- **JSON Syntax:** Use [jsonlint.com](https://jsonlint.com) to validate
- **VS Code:** Install the JSON extension for real-time validation
- **Questions:** Open an issue on the GitHub repository
