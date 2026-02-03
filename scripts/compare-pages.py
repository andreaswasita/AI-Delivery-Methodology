#!/usr/bin/env python3
"""
UX Comparison Tool for Methodology Navigator
Compares interactive elements between original and fork

Usage:
    python scripts/compare-pages.py

Requirements:
    pip install requests beautifulsoup4
"""

import json
import sys
from urllib.parse import urljoin

try:
    import requests
    from bs4 import BeautifulSoup
except ImportError:
    print("Installing required packages...")
    import subprocess
    subprocess.check_call([sys.executable, "-m", "pip", "install", "requests", "beautifulsoup4"])
    import requests
    from bs4 import BeautifulSoup


def extract_elements(url):
    """Extract all interactive elements from a page"""
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
    except requests.RequestException as e:
        return {"error": str(e), "url": url}
    
    soup = BeautifulSoup(response.text, 'html.parser')
    
    report = {
        "url": url,
        "tabs": [],
        "links": [],
        "buttons": [],
        "phases": [],
        "onclick_handlers": []
    }
    
    # Navigation tabs
    for tab in soup.select('.nav-tab'):
        report["tabs"].append({
            "text": tab.get_text(strip=True),
            "onclick": tab.get('onclick', '')
        })
    
    # All links
    for link in soup.select('a[href]'):
        href = link.get('href', '')
        report["links"].append({
            "text": link.get_text(strip=True)[:50],
            "href": href,
            "target": link.get('target', '_self')
        })
    
    # Buttons
    for btn in soup.select('button:not(.nav-tab)'):
        report["buttons"].append({
            "text": btn.get_text(strip=True)[:50],
            "onclick": btn.get('onclick', '')
        })
    
    # Phase timeline
    for phase in soup.select('.phase-item'):
        label = phase.select_one('.phase-label')
        circle = phase.select_one('.phase-circle')
        report["phases"].append({
            "label": label.get_text(strip=True) if label else '',
            "number": circle.get_text(strip=True) if circle else '',
            "onclick": phase.get('onclick', '')
        })
    
    # All onclick handlers (for comprehensive comparison)
    for elem in soup.select('[onclick]'):
        report["onclick_handlers"].append({
            "tag": elem.name,
            "onclick": elem.get('onclick', ''),
            "text": elem.get_text(strip=True)[:30]
        })
    
    return report


def compare_reports(original, fork):
    """Compare two reports and highlight differences"""
    differences = []
    
    # Compare counts
    for key in ["tabs", "links", "buttons", "phases"]:
        orig_count = len(original.get(key, []))
        fork_count = len(fork.get(key, []))
        if orig_count != fork_count:
            differences.append({
                "type": "count_mismatch",
                "element": key,
                "original": orig_count,
                "fork": fork_count
            })
    
    # Compare phases in detail
    orig_phases = original.get("phases", [])
    fork_phases = fork.get("phases", [])
    for i, (op, fp) in enumerate(zip(orig_phases, fork_phases)):
        if op.get("label") != fp.get("label"):
            differences.append({
                "type": "phase_label_mismatch",
                "index": i,
                "original": op.get("label"),
                "fork": fp.get("label")
            })
    
    # Check for extra phases in fork (our improvement!)
    if len(fork_phases) > len(orig_phases):
        for i in range(len(orig_phases), len(fork_phases)):
            differences.append({
                "type": "phase_added",
                "index": i,
                "fork": fork_phases[i]
            })
    
    # Compare links
    orig_links = {l["href"] for l in original.get("links", [])}
    fork_links = {l["href"] for l in fork.get("links", [])}
    
    missing_in_fork = orig_links - fork_links
    added_in_fork = fork_links - orig_links
    
    if missing_in_fork:
        differences.append({
            "type": "links_missing_in_fork",
            "links": list(missing_in_fork)
        })
    
    if added_in_fork:
        differences.append({
            "type": "links_added_in_fork",
            "links": list(added_in_fork)
        })
    
    return differences


def main():
    ORIGINAL_URL = "https://andreaswasita.github.io/AI-Delivery-Methodology/methodology-navigator.html"
    FORK_URL = "http://localhost:8000/methodology-navigator.html"
    
    print("=" * 60)
    print("UX COMPARISON: Original vs Fork")
    print("=" * 60)
    
    print(f"\n📥 Fetching original: {ORIGINAL_URL}")
    original = extract_elements(ORIGINAL_URL)
    
    print(f"📥 Fetching fork: {FORK_URL}")
    fork = extract_elements(FORK_URL)
    
    if "error" in original:
        print(f"❌ Error fetching original: {original['error']}")
        return 1
    
    if "error" in fork:
        print(f"❌ Error fetching fork: {fork['error']}")
        print("   Make sure local server is running: python -m http.server 8000")
        return 1
    
    print("\n" + "=" * 60)
    print("ELEMENT COUNTS")
    print("=" * 60)
    
    print(f"\n{'Element':<20} {'Original':>10} {'Fork':>10} {'Status':>10}")
    print("-" * 50)
    
    for key in ["tabs", "links", "buttons", "phases"]:
        orig_count = len(original.get(key, []))
        fork_count = len(fork.get(key, []))
        status = "✅" if orig_count == fork_count else "⚠️" if fork_count > orig_count else "❌"
        print(f"{key:<20} {orig_count:>10} {fork_count:>10} {status:>10}")
    
    print("\n" + "=" * 60)
    print("PHASE COMPARISON")
    print("=" * 60)
    
    print(f"\n{'#':<5} {'Original':<20} {'Fork':<20} {'Match':>10}")
    print("-" * 55)
    
    max_phases = max(len(original.get("phases", [])), len(fork.get("phases", [])))
    for i in range(max_phases):
        orig_phase = original.get("phases", [])[i] if i < len(original.get("phases", [])) else {}
        fork_phase = fork.get("phases", [])[i] if i < len(fork.get("phases", [])) else {}
        
        orig_label = orig_phase.get("label", "-")
        fork_label = fork_phase.get("label", "-")
        match = "✅" if orig_label == fork_label else "🆕" if orig_label == "-" else "⚠️"
        
        print(f"{i:<5} {orig_label:<20} {fork_label:<20} {match:>10}")
    
    # Detailed differences
    differences = compare_reports(original, fork)
    
    if differences:
        print("\n" + "=" * 60)
        print("DIFFERENCES DETECTED")
        print("=" * 60)
        for diff in differences:
            print(f"\n{diff['type']}:")
            for k, v in diff.items():
                if k != 'type':
                    print(f"  {k}: {v}")
    
    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)
    
    if not differences:
        print("\n✅ No breaking differences found!")
    else:
        breaking = [d for d in differences if "missing" in d["type"]]
        improvements = [d for d in differences if "added" in d["type"]]
        
        if breaking:
            print(f"\n❌ {len(breaking)} potential breaking changes")
        if improvements:
            print(f"\n🆕 {len(improvements)} improvements/additions")
    
    # Save full reports for detailed review
    with open("scripts/comparison-report.json", "w") as f:
        json.dump({
            "original": original,
            "fork": fork,
            "differences": differences
        }, f, indent=2)
    
    print("\n📄 Full report saved to: scripts/comparison-report.json")
    
    return 0


if __name__ == "__main__":
    sys.exit(main())
