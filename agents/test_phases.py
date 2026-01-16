"""
Test script for Methodology Phases feature
"""

from methodology_phases import (
    PhaseType, get_phase_info, get_all_phases,
    get_phase_by_number, get_phase_summary, display_phase_details
)


def test_phase_summary():
    """Test phase summary generation"""
    print("\n" + "="*80)
    print("TEST 1: Phase Summary")
    print("="*80)
    summary = get_phase_summary()
    assert "Phase 0: Pre-sales & Discovery" in summary
    assert "Phase 8: Operate & Care" in summary
    print("✅ Phase summary generated successfully")
    print(summary[:500] + "...")


def test_get_phase_info():
    """Test getting specific phase info"""
    print("\n" + "="*80)
    print("TEST 2: Get Phase Info")
    print("="*80)
    
    # Test Phase 4 (Build)
    build_phase = get_phase_info(PhaseType.BUILD)
    assert build_phase.name == "Build"
    assert build_phase.phase_number == 4
    assert build_phase.duration == "8-12 weeks (4-6 sprints)"
    assert len(build_phase.success_criteria) > 0
    assert len(build_phase.deliverables) > 0
    
    print(f"✅ Retrieved Phase {build_phase.phase_number}: {build_phase.name}")
    print(f"   Duration: {build_phase.duration}")
    print(f"   Success Criteria: {len(build_phase.success_criteria)} items")
    print(f"   Deliverables: {len(build_phase.deliverables)} items")


def test_get_phase_by_number():
    """Test getting phase by number"""
    print("\n" + "="*80)
    print("TEST 3: Get Phase by Number")
    print("="*80)
    
    for i in range(9):
        phase = get_phase_by_number(i)
        assert phase.phase_number == i
        print(f"✅ Phase {i}: {phase.name} ({phase.duration})")


def test_display_phase_details():
    """Test displaying phase details"""
    print("\n" + "="*80)
    print("TEST 4: Display Phase Details")
    print("="*80)
    
    # Test Mobilise phase
    details = display_phase_details(PhaseType.MOBILISE)
    assert "PHASE 1: MOBILISE" in details
    assert "SUCCESS CRITERIA:" in details
    assert "DELIVERABLES:" in details
    assert "EXIT CRITERIA:" in details
    
    print("✅ Phase details formatted correctly")
    print("\nSample output:")
    print(details[:800] + "...")


def test_all_phases():
    """Test getting all phases"""
    print("\n" + "="*80)
    print("TEST 5: Get All Phases")
    print("="*80)
    
    all_phases = get_all_phases()
    assert len(all_phases) == 9
    
    print(f"✅ Retrieved {len(all_phases)} phases")
    for phase_type, phase_info in all_phases.items():
        print(f"   - {phase_info.name}: {len(phase_info.key_objectives)} objectives, "
              f"{len(phase_info.deliverables)} deliverables")


def test_phase_content():
    """Test phase content completeness"""
    print("\n" + "="*80)
    print("TEST 6: Phase Content Completeness")
    print("="*80)
    
    all_phases = get_all_phases()
    
    for phase_type, phase_info in all_phases.items():
        # Check required fields
        assert phase_info.name, f"Phase {phase_info.phase_number} missing name"
        assert phase_info.purpose, f"Phase {phase_info.phase_number} missing purpose"
        assert phase_info.duration, f"Phase {phase_info.phase_number} missing duration"
        assert len(phase_info.key_objectives) > 0, f"Phase {phase_info.phase_number} missing objectives"
        assert len(phase_info.success_criteria) > 0, f"Phase {phase_info.phase_number} missing success criteria"
        assert len(phase_info.deliverables) > 0, f"Phase {phase_info.phase_number} missing deliverables"
        assert len(phase_info.exit_criteria) > 0, f"Phase {phase_info.phase_number} missing exit criteria"
        assert len(phase_info.key_activities) > 0, f"Phase {phase_info.phase_number} missing activities"
        assert len(phase_info.key_roles) > 0, f"Phase {phase_info.phase_number} missing roles"
        
        print(f"✅ Phase {phase_info.phase_number} ({phase_info.name}): All content complete")


def run_all_tests():
    """Run all tests"""
    print("\n" + "="*80)
    print("METHODOLOGY PHASES - FUNCTIONALITY TEST")
    print("="*80)
    
    tests = [
        test_phase_summary,
        test_get_phase_info,
        test_get_phase_by_number,
        test_display_phase_details,
        test_all_phases,
        test_phase_content
    ]
    
    passed = 0
    failed = 0
    
    for test in tests:
        try:
            test()
            passed += 1
        except AssertionError as e:
            print(f"❌ Test failed: {test.__name__}")
            print(f"   Error: {str(e)}")
            failed += 1
        except Exception as e:
            print(f"❌ Test error: {test.__name__}")
            print(f"   Error: {str(e)}")
            failed += 1
    
    print("\n" + "="*80)
    print("TEST SUMMARY")
    print("="*80)
    print(f"Total Tests: {passed + failed}")
    print(f"✅ Passed: {passed}")
    print(f"❌ Failed: {failed}")
    print("="*80)
    
    if failed == 0:
        print("\n🎉 All tests passed! Methodology phases module is working correctly.")
    else:
        print(f"\n⚠️  {failed} test(s) failed. Please review errors above.")
    
    return failed == 0


if __name__ == "__main__":
    success = run_all_tests()
    exit(0 if success else 1)
